class BooksController < ApplicationController

  def search
    if params[:keyword]
      books = RakutenWebService::Books::Book.search(title: params[:keyword])
      @books = []
      books.each do |item|
        book = Book.new(
          title: item.title,
          author: item.author,
          story: item.item_caption,
          image: item.large_image_url,
          rakuten_url: item.item_url
        )
        @books << book
      end
    end
  end

  def new
    @book = Book.new(book_params)
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "本を投稿しました"
      redirect_to book_path(@book.id)
    else
      render 'new'
    end      
  end

  def show
    @book = Book.find(params[:id])
  end

  private

        def book_params
            params.require(:book).permit(:title, :author, :story, :image,
                                         :rakuten_url, :contributor_review)
        end

end
