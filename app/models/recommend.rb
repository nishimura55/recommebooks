class Recommend < ApplicationRecord
    belongs_to :recommender, class_name: "User"
    belongs_to :recommended, class_name: "User"
    belongs_to :book
    validates :book_id, uniqueness: { scope: [:recommender_id, :recommended_id]  }
    validates :status, presence: true
    has_many :notifications, dependent: :destroy

    def create_notification_recommend!
        create_notification!('recommend')
    end

    def create_notification_response!
        create_notification!('response')
    end

    def create_notification!(action)
        notification = recommender.notifications.where(visited: recommended, recommend_id: id, action: action)
        if notification.blank?
            new_notification = self.recommended.active_notifications.new(visited_id: recommender_id, recommend_id: id, action: action)
            new_notification.save! if new_notification.valid?
        end
    end
end
