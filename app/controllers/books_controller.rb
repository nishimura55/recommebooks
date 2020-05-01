class BooksController < ApplicationController

  before_action :logged_in_user, only: [:search, :new, :create]
  before_action :admin_user,     only: :destroy
  before_action :set_genre,     only: [:new, :create]
  before_action :set_book, only: [:show, :destroy]

  def search
    if !params[:keyword].to_s.empty?
      books = RakutenWebService::Books::Book.search(title: params[:keyword])
      @books = books.map do |item|
        {
          title: item.title,
          author: item.author,
          story: item.item_caption,
          image: item.large_image_url,
          rakuten_url: item.item_url
        }
      end
    end
  end

  def new
    @book = Book.new(book_params)
    unless params[:book][:author].empty?
      @author_name = params[:book][:author].to_s.gsub(" ", "").gsub("　", "")
    else
      @author_name = "作者不明"
    end 
  end

  def create
    @book = current_user.books.build(book_params)
    if !params[:book][:genre_ids].nil? && @book.save
      author = Author.find_or_create_by(name: params[:book][:author])
      @book.update(author: author)
      @book.save_feelings(params[:book][:feeling_ids]) unless params[:book][:feeling_ids].nil?
      @book.save_genres(params[:book][:genre_ids])
      flash[:primary] = "本を投稿しました"
      redirect_to book_path(@book.id)
    else
      @author_name = params[:book][:author]
      flash.now[:danger] = "投稿に失敗しました"
      render 'new'
    end
  end

  def show
    @review = Review.new
    if logged_in?
      @my_review = current_user.reviews.find_by(book: @book)
      @reviews = @book.reviews.where.not(user_id: current_user.id).paginate(page: params[:page])
    else
      @reviews = @book.reviews.paginate(page: params[:page])
    end
  end

  def destroy
    @book.destroy
    flash[:primary] = "削除しました"
    redirect_to books_path
  end

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).paginate(page: params[:page])
    if @q_header
      @books = @q_header.result(distinct: true).paginate(page: params[:page])
    end
    if params[:feeling_id]
      @feeling = Feeling.find(params[:feeling_id])
      @books = @feeling.books.paginate(page: params[:page])
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @books = @genre.books.paginate(page: params[:page])
    end
  end

  private

        def book_params
            params.require(:book).permit(:title, :story, :image, :rakuten_url, :contributor_review )
        end

        def set_genre
          @genre = { "1": "文学・小説", "2": "社会・ビジネス", "3": "趣味・実用", "4": "芸術・教養・エンタメ",
                     "5": "旅行・地図", "6": "暮らし・健康", "7": "図鑑・百科事典", "8": "こども", "9": "コミック" } 
        end

        def set_book
          @book = Book.find(params[:id])
        end
end
