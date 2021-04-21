class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true

  def create_notification_chat(current_user)
    rooms = room.user_rooms
    visited_user_room = rooms.find_by('user_id != ?', current_user.id)
    notification = current_user.active_notifications.new(
      visitor_id: current_user.id,
      visited_id: visited_user_room.user_id,
      request_id: room.request_id,
      action: 'chat'
    )
    notification.save
  end
end
