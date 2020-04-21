class BookFeeling < ApplicationRecord
    belongs_to :book
    belongs_to :feeling
end
