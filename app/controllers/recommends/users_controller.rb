class Recommends::UsersController < ApplicationController

    def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true).order(created_at: "DESC").paginate(page: params[:page])
    end
    
end
