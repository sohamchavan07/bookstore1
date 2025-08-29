module Api
  module V1
    class BooksController < ApplicationController
      # GET /api/v1/books
      def index
        books = Book.all
        render json: BookSerializer.new(books).serializable_hash, status: :ok
      end

      # GET /api/v1/books/:id
      def show
        book = Book.find_by(id: params[:id])
        if book
          render json: BookSerializer.new(book).serializable_hash, status: :ok
        else
          render json: { error: "Book not found" }, status: :not_found
        end
      end

      # POST /api/v1/books
      def create
        book = Book.new(book_params)
        if book.save
          render json: BookSerializer.new(book).serializable_hash, status: :created
        else
          render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :price, :category_id)
      end
    end
  end
end
