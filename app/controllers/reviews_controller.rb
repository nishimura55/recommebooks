class ReviewsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
    before_action :set_book, only: [:create, :destroy, :edit, :update]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def create
        @review = current_user.reviews.build(review_params)
        @review.book_id = params[:book_id]
        @reviews = @book.reviews.where.not(user_id: current_user.id).paginate(page: params[:page])
        if @review.save
          flash[:primary] = "レビューを投稿しました"
          redirect_to @book
        else
          flash.now[:danger] = "投稿に失敗しました"
          render template: 'books/show'
        end
    end

    def edit
        @review = current_user.reviews.find_by(book_id: params[:book_id])
        @reviews = @book.reviews.where.not(user_id: current_user.id).paginate(page: params[:page])
    end

    def update
        @review = current_user.reviews.find_by(book_id: params[:book_id])
        @reviews = @book.reviews.where.not(user_id: current_user.id).paginate(page: params[:page])
        if @review.update_attributes(review_params)
            flash[:primary] = "レビューを編集しました"
            redirect_to @book
        else
            flash.now[:danger] = "編集に失敗しました"
            render template: 'reviews/edit'
        end
    end

    def destroy
        @review = current_user.reviews.find_by(book_id: params[:book_id])
        @review.destroy
        flash[:primary] = "レビューを削除しました"
        redirect_to @book
    end

    private
   
    def set_book
      @book = Book.find_by(id: params[:book_id])
    end

    def review_params
        params.require(:review).permit(:title, :content, :spoiler)
    end

    def correct_user
        @book = Book.find_by(id: params[:book_id])
        unless current_user.reviews.find_by(book_id: @book.id).present?
            flash[:danger] = "無効な処理です"
            redirect_to(root_url)                      
        end
    end

end