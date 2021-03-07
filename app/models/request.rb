class Request < ApplicationRecord

  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"

  attachment :reference_image
  attachment :complete_image

  enum file_format: { お任せ: 0, jpg: 1, png: 2 }
  enum request_status: { 未受付: 0, 受付不可: 1, 製作中: 2, 製作完了: 3 }

  validates :request_introduction, presence: true
  validates :file_format, presence: true
  validates :use, presence: true
  validates :deadline, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 1 }
  validates :request_status, presence: true
  validate :deadline_limit, on: [:create, :update]
  validates :complete_image, presence: true, on: :update_request_complete_image

  def deadline_limit
    if deadline.present?
      errors.add(:deadline, 'は、最短で本日から3日後で設定してください') if deadline < Time.now || deadline < Time.current.since(2.days)
    end
  end
end
