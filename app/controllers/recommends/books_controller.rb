class Recommends::BooksController < ApplicationController

    def index
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true).paginate(page: params[:page])
        @user_id = params[:user_id] || params.dig(:q, :user_id)
    end
    
end
