class BooksRepresenter
    def initialize(books)
        @books = books
    end

    def as_json
        books.map do |books|
            {
                id: book.id,
                name: book.title,
                # author_first_name: book.author.first_name,
                # author_last_name: book.author.last_name,
                # author_name: "#{book.author.first_name} #{book.author.last_name}",
                author_name:  "#{book.author_name}",
                author_age: book.author.age
            }
        end
    end

    private

    attr_reader :books

    def author_name(book)
        "#{book.author.first_name} #{book.author.last_name}"
    end
end