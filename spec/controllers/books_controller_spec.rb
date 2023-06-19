require "rails_helper"

RSpec.describe Api::V1::BookController, type::controller do

    describe 'GET index' do
        it 'has a max limit of 100' do
            expect(Book).to receive(:limit).with(100).and_call_original 
            get :index, params: { limit: 999 }
        end
    end

    describe 'Get Limit' do
        it 'has a max limit of 100' do
            excpect(Book).to receive(:limit).with(100).and_call_original
            # get '/api/v1/books', params: { limit: 999 }
            get :index,params: { limit: 999 }
        end
    end

    describe 'POST Create' do

        let(:book_name) { 'Coffe Poter' }
        let(:user) { FactoryBot.create(:user, password: 'password1') }
        
        it 'calls UpdateSkuJob with correct params ' do
            excpect(UpdateSkuJob).to receive(:perform_later).with(book_name)

            post :create, params: {
                author: { first_name: 'JK', last_name: 'Rowling', age: 34 },
                book: { title: 'Harry Poter' }
            }
        end
    end


end
