class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_book, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.build(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
    favorite.save
    respond_to do |format|
        format.html { redirect_to @book }
        format.js
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
    favorite.destroy
    respond_to do |format|
        format.html { redirect_to @book }
        format.js
    end
  end

  private
   
    def set_book
      @book = Book.find_by(id: params[:book_id])
    end

end
