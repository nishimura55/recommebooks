class User < ApplicationRecord
    has_many :books, dependent: :destroy
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
end
