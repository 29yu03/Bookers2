class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def show
  end

  def index
    @books = Book.all
    @user = current_user
  end

  private
  def book_params
    params.require(:book).permit(:name, :image, :title, :body)
  end

end


