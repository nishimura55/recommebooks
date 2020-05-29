class User < ApplicationRecord
    belongs_to :title

    has_many :books

    has_many :favorites, dependent: :destroy
    has_many :favorite_books, through: :favorites, source: :book

    has_many :reviews, dependent: :destroy

    has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :passive_relationships, class_name:  "Relationship",
                                     foreign_key: "followed_id",
                                     dependent:   :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    has_many :active_recommends, class_name:  "Recommend",
                                    foreign_key: "recommender_id",
                                    dependent:   :destroy
    has_many :recommending, through: :active_recommends, source: :recommended
    has_many :passive_recommends, class_name:  "Recommend",
                                     foreign_key: "recommended_id",
                                     dependent:   :destroy
    has_many :recommenders, through: :passive_recommends, source: :recommender

    has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
    has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

    has_many :user_genres, dependent: :destroy
    has_many :genres, through: :user_genres

    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 45 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                      length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }
    validates :favorite_genre, length: { maximum: 45 }
    validates :profile, length: { maximum: 255 }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    mount_uploader :image, ImageUploader

    def time_line_feed_books
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        Book.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end

    def time_line_feed_reviews
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        Review.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end

    def follow(other_user)
        following << other_user
    end

    def unfollow(other_user)
        active_relationships.find_by(followed: other_user).destroy
    end

    def following?(other_user)
        following.include?(other_user)
    end

    def save_genres(tag_ids)
        current_tag_ids = self.genres.pluck(:id) unless self.genres.nil?
        old_tag_ids = current_tag_ids - tag_ids
        new_tag_ids = tag_ids - current_tag_ids
    
        old_tag_ids.each do |old_tag_id|
          self.user_genres.find_by(genre_id: old_tag_id).delete
        end
    
        new_tag_ids.each do |new_tag_id|
          self.genres << Genre.find_by(id: new_tag_id)
        end
    end

    def create_notification_follow!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
        if temp.blank?
            notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
            notification.save! if notification.valid?
        end
    end

    def update_title_or_not
        if self.recomme_point == 5 || self.recomme_point == 15
            self.increment!(:title_id, 1)
        end
    end

end
