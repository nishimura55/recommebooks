module BooksHelper

    def posted?(book_rakuten_url)
        !Book.find_by(rakuten_url: book_rakuten_url).nil?
    end

end
