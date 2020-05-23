class RecommendsController < ApplicationController

    before_action :logged_in_user

    def new
        @recommend = Recommend.new
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
        end
        if params[:book_id]
            @book = Book.find_by(id: params[:book_id])
        end
    end

    def create
        @recommend = Recommend.new(recommend_params)
        if @recommend.save
            @recommend.create_notification_recommend!
            flash[:primary] = "レコメンドが完了しました！"
            redirect_to user_recommends_path(current_user.id)
        else
            flash.now[:danger] = "レコメンドに失敗しました"
            render 'new'
        end
    end

    def index
        @user = User.find(params[:user_id])
        @active_recommends = @user.active_recommends.order(created_at: :desc).paginate(page: params[:page])
        @passive_recommends = @user.passive_recommends.order(created_at: :desc).paginate(page: params[:page])
    end

    def update
        recommend = Recommend.find(params[:id])
        if recommend.update_attributes(recommend_params)
            recommend.create_notification_response!
            # statusカラムはgemのenumerzieを使いたい
            if recommend.status == 2
                recommend.recommender.increment!(:recomme_point, 1)
                recommend.recommender.update_title_or_not
                recommend.book.increment!(:recomme_evaluation_point, 1)
            end
            redirect_to user_recommends_path(current_user.id), primary: 'レコメンドに対する回答を完了しました！'
        else
            flash[:danger] = "回答に失敗しました"
            redirect_to user_recommends_path(current_user.id)
        end
    end

    private

        def recommend_params
            params.require(:recommend).permit(:recommender_id, :recommended_id, :book_id, :body, :status)
        end
end
