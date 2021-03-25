class Request < ApplicationRecord

  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
  has_one :room, dependent: :destroy
  has_many :request_images, dependent: :destroy
  has_many :notifications, dependent: :destroy

  accepts_attachments_for :request_images, attachment: :complete_image, append: true

  attachment :reference_image

  enum file_format: { お任せ: 0, jpg: 1, png: 2 }
  enum request_status: { 未受付: 0, 受付不可: 1, 製作中: 2, 製作完了: 3 }

  validates :request_introduction, presence: true
  validates :file_format, presence: true
  validates :use, presence: true
  validates :deadline, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates :request_status, presence: true
  validates :request_images_complete_images, presence: true, on: :update_complete_image
  validate :deadline_limit, on: [:create, :update]

  def deadline_limit
    if deadline.present?
      errors.add(:deadline, 'は、最短で本日から3日後で設定してください') if deadline < Time.now || deadline < Time.current.since(2.days)
    end
  end

  def create_notification_request(current_user)
    notification = current_user.active_notifications.new(
      request_id: id,
      visitor_id: requester_id,
      visited_id: requested_id,
      action: 'request'
    )
    notification.save
  end

  #製作ステータスが更新された時
  def create_notification_request_status(current_user)
    if self.request_status === "製作中"
      notification = current_user.active_notifications.new(
        request_id: id,
        visitor_id: requested_id,
        visited_id: requester_id,
        action: 'request_ok'
      )
      notification.save
    elsif self.request_status === "受付不可"
      notification = current_user.active_notifications.new(
        request_id: id,
        visitor_id: requested_id,
        visited_id: requester_id,
        action: 'request_out'
      )
      notification.save
    elsif self.request_status === "製作完了"
      notification = current_user.active_notifications.new(
        request_id: id,
        visitor_id: requested_id,
        visited_id: requester_id,
        action: 'request_complete'
      )
      notification.save
    end
  end
end
