class SessionsController < ApplicationController

  before_action :logged_in_user, only: [:destroy]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:primary] = 'ログインしました'
      redirect_back_or user
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end

  end

  def destroy
    log_out
    flash[:primary] = 'ログアウトしました'
    redirect_to root_url
  end

end
