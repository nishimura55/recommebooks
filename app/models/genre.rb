class Genre < ApplicationRecord
    has_many :book_genres, dependent: :destroy
    has_many :books, through: :book_genres
    has_many :user_genres, dependent: :destroy
    has_many :users, through: :user_genres
    validates :name, presence: true
end
