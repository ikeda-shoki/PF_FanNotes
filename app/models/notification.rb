class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post_image, optional: true
  belongs_to :request, optional: true
  
  belongs_to :visitor, class_name: 'User'
  belongs_to :visited, class_name: 'User'
end