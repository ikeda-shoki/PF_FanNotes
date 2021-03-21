class NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.passive_notifications.all
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy
    Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end
  
  def all_destroy
    user_notifications = Notification.where(visited_id: current_user.id)
    user_notifications.destroy_all
    redirect_to notifications_path
  end
  
end
