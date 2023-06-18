module Api
  module v1
    
    class Api::V1::BookController < ApplicationController

      def index
        render json: Book.all
      end
    
      def create  
        book = Book.new(title: params[:title], author: [:author])
    
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
      def book_params
          params.required(:book).permint([
            :title,
            :author
          ])
      end
    
    end
  end
end
