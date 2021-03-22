class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.passive_notifications.all
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy
    Notification.find(params[:id]).destroy
    @notifications = current_user.passive_notifications.all
  end
  
  def all_destroy
    user_notifications = Notification.where(visited_id: current_user.id)
    user_notifications.destroy_all
    @notifications = current_user.passive_notifications.all
  end
  
end
