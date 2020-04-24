class Recommends::BooksController < ApplicationController

    def index
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true).paginate(page: params[:page])
    end
    
end
