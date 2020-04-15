class AuthorsController < ApplicationController

    def index
        @authors = Author.paginate(page: params[:page])
    end

    def show
        @author = Author.find(params[:id])
        @books = @author.books.paginate(page: params[:page])
    end

end