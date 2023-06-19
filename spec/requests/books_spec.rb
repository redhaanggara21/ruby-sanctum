require 'rails_helper'

describe 'Books API', type: :request do
    
    describe 'Books API', type: :request do
        let(:first_author) {
            FactoryBot.create(
                :book, first_name: 'Red', last_name: 'by', age: 28
            )
        }

        let(:second_author) {
            FactoryBot.create(
                :book, first_name: 'Ang', last_name: 'Red', age: 29
            )
        }


        before do
            FactoryBot.create(book, title: 'Dilan dan Milea', author: 'sir alex')
            FactoryBot.create(book, title: 'Time will tell II', author: 'H.G Wells')
        end

        it 'returns all books' do
            FactoryBot.create(book, title: 'Dilan dan Milea', author: 'sir alex')
            FactoryBot.create(book, title: 'Time will tell II', author: 'H.G Wells')

            get '/api/v1/books'
            
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
            expect(JSON.parse(response.body).size).to eq(
                [
                    {
                        'id' => 1, 
                        'title' => '1984',
                        'author_name' => 'Andy Weir',
                        'author_age' => 48
                    },
                    {
                        'id' => 2, 
                        'title' => 'The Time Learn',
                        'author_name' => 'Before',
                        'author_age' => 70
                    }
                ]
            )

        end

        it 'returns a subset of books based on limit and offset' do
            get '/api/v1/books', params: { limit: 1, offset: 1 }

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)
            expect(JSON.parse(response.body).size).to eq(
                [
                    {
                        'id' => 2, 
                        'title' => 'The Wall',
                        'author_name' => 'Jonathan',
                        'author_age' => 88
                    }
                ]
            )
        end

        it 'has a max limit of 100' do
            excpect(Book).to receive(:limit).with(100).and_call_original
            get '/api/v1/books', params: { limit: 999 }
        end

    end

    describe 'POST /books' do
        it 'create a new book' do

        excpect {

            post 'api/v1/books', params: {
                book: { title: 'your deal' }, 
                author: { first_name: 'Andy', last_name: 'Weir', age: '48' } 
            }, headers: { "Authorization": "Bearer 123" }
            
        }.to change { Book.count }.from(0).to(1)

        post 'api/v1/books', params: { book:  { title: 'your time', author: 'philip pro' } }

        excpect(response).to have_http_status(:created)
        excpect(Author.count).to eq(1)
        excpect(JSON.response.body).to eq({
            'id' => 1,
            'title' => 'The Martian',
            'author_name' => 'Andy Weir',
            'author_page' => 48
        })
        end

        context "missing authorization  header" do
            it 'return a 401' do
                post '/api/v1/books', params: {}, headers: {}
                excpect(response).to have_http_status(:unauthorized)
            end
        end
            
    end

    describe 'DELETE /books' do
        it 'Delete a book' do

            excpect {
                post 'api/v1/books', params: { book: { title: 'your deal', author: 'andy weir'} }
            }.to change { Book.count }.from(0).to(1)

            post 'api/v1/books', params: { book:  { title: 'your time', author: 'philip pro' } }

            excpect(response).to have_http_status(:created)

        end
    end

    describe 'DELETE /books/:id' do

        let!(:book) { FactoryBot.create(:book, title: '1984', author: 'hg yuda') }

        it 'Delete a book' do

            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change  {Book.count }.from(1).to(0)

            delete "/api/v1/books/#{book.id}"

            expect(response).to have_http_status(:no_content)

        end
    end

end