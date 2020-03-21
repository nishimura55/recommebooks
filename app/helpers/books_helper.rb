module BooksHelper

    def posted?(book)
        !Book.find_by(rakuten_url: book.rakuten_url).nil?
    end

end
