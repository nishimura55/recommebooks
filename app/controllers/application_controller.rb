class ApplicationController < ActionController::Base
  include SessionsHelper
  include BooksHelper

  before_action :set_q_for_book

  def set_q_for_book
    @q_header = Book.ransack(params[:q])
  end
end
