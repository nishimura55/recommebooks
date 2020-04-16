class BooksController < ApplicationController

  before_action :logged_in_user, only: [:search, :new, :create]
  before_action :admin_user,     only: :destroy

  def search
    if !params[:keyword].to_s.empty?
      books = RakutenWebService::Books::Book.search(title: params[:keyword])
      @books = []
      books.each do |item|
        book = {
          title: item.title,
          author: item.author,
          story: item.item_caption,
          image: item.large_image_url,
          rakuten_url: item.item_url
        }
        @books << book
      end
    end
  end

  def new
    @book = Book.new(book_params)
    unless params[:book][:author].empty?
      @author_name = params[:book][:author].gsub(" ", "")
    else
      @author_name = "作者不明"
    end 
  end

  def create
    @book = current_user.books.build(book_params)
    if Author.find_by(name: params[:book][:author]).present?
      author_id_for_book = Author.find_by(name: params[:book][:author]).id
    else
      new_author = Author.new(name: params[:book][:author])
    end
    if @book.save
      unless new_author.nil?
        new_author.save
        author_id_for_book = new_author.id
      end
      @book.update( author_id: author_id_for_book )
      flash[:success] = "本を投稿しました"
      redirect_to book_path(@book.id)
    else
      @author_name = params[:book][:author]
      flash.now[:danger] = "感想を入力してください"
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
    if logged_in?
      @my_review = current_user.reviews.find_by(book_id: params[:id])
      @reviews = @book.reviews.where.not(user_id: current_user.id).paginate(page: params[:page])
    else
      @reviews = @book.reviews.paginate(page: params[:page])
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to books_path
  end

  def index
    @books = Book.paginate(page: params[:page])
  end

  private

        def book_params
            params.require(:book).permit(:title, :story, :image,
                                         :rakuten_url, :contributor_review)
        end

end
