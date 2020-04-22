class AuthorsController < ApplicationController

    def index
        @q = Author.ransack(params[:q])
        @authors = @q.result(distinct: true).paginate(page: params[:page])
    end

    def show
        @author = Author.find(params[:id])
        @books = @author.books.paginate(page: params[:page])
    end

end