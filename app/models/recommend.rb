class Recommend < ApplicationRecord
    belongs_to :recommender, class_name: "User"
    belongs_to :recommended, class_name: "User"
    belongs_to :book
    validates :book_id, uniqueness: { scope: [:recommender_id, :recommended_id]  }
end
