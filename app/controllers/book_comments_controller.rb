class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.js
      end
    else
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to book_path(@book) }
      format.js
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
