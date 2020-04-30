class StaticPagesController < ApplicationController
  def home
    @ranking_books = Book.reorder(recomme_evaluation_point: "DESC").limit(4)
    @ranking_users = User.reorder(recomme_point: "DESC").limit(4)
  end

  def about
  end
end
