class Recommend < ApplicationRecord
    belongs_to :recommender, class_name: "User"
    belongs_to :recommended, class_name: "User"
    belongs_to :book
    validates :book_id, uniqueness: { scope: [:recommender_id, :recommended_id]  }
    validates :status, presence: true
    has_many :notifications, dependent: :destroy

    def create_notification_recommend!
        temp = Notification.where(["visitor_id = ? and visited_id = ? and recommend_id = ? and action = ? ",
                                    recommender_id, recommended_id, id, 'response'])
        if temp.blank?
            notification = self.recommender.active_notifications.new(visited_id: recommended_id, recommend_id: id, action: 'recommend')
            notification.save if notification.valid?
        end
    end

    def create_notification_response!
        temp = Notification.where(["visitor_id = ? and visited_id = ? and recommend_id = ? and action = ? ",
                                   recommender_id, recommended_id, id, 'response'])
        if temp.blank?
            notification = self.recommended.active_notifications.new(visited_id: recommender_id, recommend_id: id, action: 'response')
            notification.save if notification.valid?
        end
    end
end
