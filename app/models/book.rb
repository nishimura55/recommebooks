class Book < ApplicationRecord
  belongs_to :user
  belongs_to :author, optional: true
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :book_feelings, dependent: :destroy
  has_many :feelings, through: :book_feelings
  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres
  
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :contributor_review, presence: true, length: { maximum: 255 }
  validates :rakuten_url, presence: true, uniqueness: { case_sensitive:  true }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def when_favorited_by?(user)
    if favorited_by?(user)
      Favorite.find_by(book_id: id, user_id: user.id).created_at
    end
  end

  def save_feelings(feeling_ids)
    feeling_ids.each do |feeling_id|
      book_feeling = Feeling.find_by(id: feeling_id)
      self.feelings << book_feeling
    end
  end

  def save_genres(genre_ids)
    genre_ids.each do |genre_id|
      book_genre = Genre.find_by(id: genre_id)
      self.genres << book_genre
    end
  end

end