class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :contributor_review, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :rakuten_url, presence: true, uniqueness: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
