class Feeling < ApplicationRecord
    has_many :book_feelings, dependent: :destroy
    has_many :books, through: :book_feelings
    validates :situation, presence: true
end
