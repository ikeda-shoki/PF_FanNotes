class Notification < ApplicationRecord
  belongs_to :post_image, optional: true
  belongs_to :request, optional: true

  belongs_to :visitor, class_name: 'User'
  belongs_to :visited, class_name: 'User'

  def self.is_favite_notification(visitor, visited, post_image)
    where(["visitor_id = ? and visited_id = ? and post_image_id = ? and action = ?", visitor, visited, post_image, 'favorite'])
  end

  scope :checked, -> { where(checked: false) }
end
