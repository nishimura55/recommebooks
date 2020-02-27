class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 45 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :favorite_genre, length: { maximum: 45 }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
