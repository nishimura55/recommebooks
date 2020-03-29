class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user,     only: :destroy
    require 'will_paginate/array'

    def index
        @users = User.paginate(page: params[:page])
    end
    
    def show
        @user = User.find(params[:id])
        @post_feed_books = @user.books.paginate(page: params[:page])
        if logged_in? && current_user?(@user)
            @time_line_feed_books = current_user.time_line_feed_books.paginate(page: params[:page]) 
            @favorite_books = @user.favorites.order(created_at: "DESC").map{|favorite| favorite.book}.paginate(page: params[:page])
        end
        
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "ユーザー登録が完了しました。レコメブックスへようこそ！"
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "プロフィールを更新しました"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "削除しました"
        redirect_to users_url
    end

    private

        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                         :favorite_genre, :profile, :image)
        end

        def correct_user
            @user = User.find(params[:id])
            unless current_user?(@user)
                flash[:danger] = "無効な処理です"
                redirect_to(root_url)                      
            end
        end

end
