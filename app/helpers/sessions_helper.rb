module SessionsHelper

    # コントローラに書きたい
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "ログインが必要です"
            redirect_to login_url
        end
    end

    # コントローラに書きたい
    # メソッド名と処理内容が合っていない(例:redirect_to_unless_admin_user)
    def admin_user
        redirect_to(root_url) unless current_user.admin? 
    end

    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def current_user?(user)
        user == current_user
    end

    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
end
