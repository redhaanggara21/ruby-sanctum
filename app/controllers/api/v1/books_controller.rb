require 'net/http'

module Api
  module V1
    
    class Api::V1::BookController < ApplicationController
      MAX_PAGINATION_LIMIT = 100
      before_action :some_method

      def index
        # books =  Book.all
        books =  Book.limit(params[:limit]).offset(params[:offset])
        render json: BookRepresenter.new(books).as_json
      end
    
      def create  
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
        # book = Book.new(title: params[:title], author: [:author])
        # UpdateSkuJob.perform_later(book_params[:name])
        UpdateSkuJob.perform_later(book_params[:title])
        # uri = URI('http://localhost:4567/update_sku')
        # req = Net::HTTP.Post.new(uri, 'Content-Type' => 'application/json')
        # req.body = {
        #   sku: '123',
        #   name: book_params[:name].to_json
        # }

        # res = Net::HTTP.start(uri.hostname, uri.port) do [http]
        #   http.request(req)
        # end

        # raise exit

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unproccessable_entity
        end
      end
    
      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      rescue ActiveRecord::RecordNotDestroyed
        render json: {}, status: :unproccessable_entity
      end
    
      private

      def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        # user_id.find(user_id)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound
          render status::unauthorized
        # raise token.inspect
      end

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, 
          100
        ].min
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
          params.required(:book).permit([
            :title,
            :author
          ])
      end
    
    end
  end
end
