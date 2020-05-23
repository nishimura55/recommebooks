class NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.paginate(page: params[:page])
    @notifications.where(checked: false).update_all(checked: true)
  end
end
