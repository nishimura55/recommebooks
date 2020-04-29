class ApplicationController < ActionController::Base
  include SessionsHelper
  include BooksHelper

  before_action :set_q_for_book
  before_action :set_recently_recommend_book

  def set_q_for_book
    @q_header = Book.ransack(params[:q])
  end

  def set_recently_recommend_book
    @recently_recommend_book = Recommend.last.book unless Recommend.count == 0
  end
end
