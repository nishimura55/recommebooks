class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user,     only: :destroy
    before_action :set_genre,     only: [:edit, :update]
    require 'will_paginate/array'

    def index
        @users = User.order(created_at: "DESC").paginate(page: params[:page])
    end
    
    def show
        @user = User.find_by(id: params[:id])
        @post_feed_books = @user.books.paginate(page: params[:page])
        @post_feed_reviews = @user.reviews.paginate(page: params[:page])
        @following = @user.active_relationships.order(created_at: "DESC").map{|active_relationship| active_relationship.followed}.paginate(page: params[:page])
        @followers = @user.passive_relationships.order(created_at: "DESC").map{|passive_relationship| passive_relationship.follower}.paginate(page: params[:page])
        if logged_in? && current_user?(@user)
            @time_line_feed_books = current_user.time_line_feed_books.paginate(page: params[:page]) 
            @time_line_feed_reviews = current_user.time_line_feed_reviews.paginate(page: params[:page]) 
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
            unless params[:user][:genre_ids].nil?
                @user.save_genres(params[:user][:genre_ids].map(&:to_i)) #配列にstring型でidが格納されているため、integer型に変換して配列化
            else
                @user.save_genres([])
            end
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

        def set_genre
            @genre = { "1": "文学・小説", "2": "社会・ビジネス", "3": "趣味・実用", "4": "芸術・教養・エンタメ",
                       "5": "旅行・地図", "6": "暮らし・健康", "7": "図鑑・百科事典", "8": "こども", "9": "コミック" } 
        end

end
