module BooksHelper

    def posted?(book)
        !Book.find_by(rakuten_isbn: book.rakuten_isbn).nil?
    end

end
