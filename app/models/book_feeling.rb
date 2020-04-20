class BookFeeling < ApplicationRecord
    belongs_to :book
    belongs_to :feeling

    validates :book_id, presence: true
    validates :feeling_id, presence: true

end
