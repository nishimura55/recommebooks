class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book

    default_scope -> { order(created_at: :desc) }
    validates :book_id, uniqueness: {scope: [:user_id]}
    validates :title, length: { maximum: 45 }
    validates :content, presence: true, length: { maximum: 500 }
end
