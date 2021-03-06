class Request < ApplicationRecord
  
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
  
  attachment :reference_image
  
  enum file_format: { お任せ: 0, jpg: 1, png: 2 }
end
