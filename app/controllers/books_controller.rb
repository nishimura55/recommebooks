class BooksController < ApplicationController

  before_action :logged_in_user, only: [:search, :new, :create]
  before_action :admin_user,     only: :destroy
  before_action :set_genre,     only: [:new, :create]

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
      @author_name = params[:book][:author].to_s.gsub(" ", "").gsub("　", "")
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
    if !params[:book][:genre_ids].nil? && @book.save
      unless new_author.nil?
        new_author.save
        author_id_for_book = new_author.id
      end
      @book.update( author_id: author_id_for_book )
      @book.save_feelings(params[:book][:feeling_ids]) unless params[:book][:feeling_ids].nil?
      @book.save_genres(params[:book][:genre_ids])
      flash[:success] = "本を投稿しました"
      redirect_to book_path(@book.id)
    else
      @author_name = params[:book][:author]
      flash.now[:danger] = "投稿に失敗しました"
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
    if params[:feeling_id]
      @feeling = Feeling.find(params[:feeling_id])
      @books = @feeling.books.paginate(page: params[:page])
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @books = @genre.books.paginate(page: params[:page])
    else
      @books = Book.paginate(page: params[:page])
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

end
