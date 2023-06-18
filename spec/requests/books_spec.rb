require 'rails_helper'

describe 'Books API', type: :request do
    
    describe 'Books API', type: :request do

        before do
            FactoryBot.create(book, title: 'Dilan dan Milea', author: 'sir alex')
            FactoryBot.create(book, title: 'Time will tell II', author: 'H.G Wells')
        end

        it 'returns all books' do
            FactoryBot.create(book, title: 'Dilan dan Milea', author: 'sir alex')
            FactoryBot.create(book, title: 'Time will tell II', author: 'H.G Wells')

            get '/api/v1'
            
            expect(response).to have_http_status(:success)
            expect(
                JSON.parse(response.body.size)
            ).to eq(:success)
        end
    end

    describe 'POST /books' do
        it 'create a new book' do

            excpect {
                post 'api/v1/books', params: { book: { title: 'your deal', author: 'andy weir'} }
            }.to change { Book.count }.from(0).to(1)

            post 'api/v1/books', params: { book:  { title: 'your time', author: 'philip pro' } }

            excpect(response).to have_http_status(:created)

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