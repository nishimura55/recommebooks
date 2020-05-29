class ApplicationController < ActionController::Base
    include SessionsHelper
    include BooksHelper
  
    before_action :set_q_for_book
    before_action :set_recently_recommend_book
  
    def set_q_for_book
      @q_header = Book.ransack(params[:q])
    end
  
    def set_recently_recommend_book
      @recently_recommend_book = Recommend.last.book if Recommend.count.nonzero?
    end

    
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "ログインが必要です"
            redirect_to login_url
        end
    end
  
    def admin_user
        redirect_to(root_url) unless current_user.admin? 
    end

    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
  
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
end
