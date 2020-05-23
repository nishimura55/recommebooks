module NotificationsHelper
    def unchecked_notifications
        # ヘルパーで変数をセットしないようにしたい
        @notifications = current_user.passive_notifications.where(checked: false)
    end
end
