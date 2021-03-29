module NotificationsHelper
  # 通知ボタンのマークの為（未読があるかの確認）
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
