class RequestImage < ApplicationRecord
  
  belongs_to :request
  
  attachment :complete_image
  
  validates :complete_image, presence: true
end
