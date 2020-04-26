class Recommends::UsersController < ApplicationController

    def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true).order(created_at: "DESC").paginate(page: params[:page])
        @book_id = params[:book_id] || params.dig(:q, :book_id)
    end
    
end
