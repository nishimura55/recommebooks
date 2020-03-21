class Book < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :contributor_review, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :rakuten_url, presence: true, uniqueness: true
end
