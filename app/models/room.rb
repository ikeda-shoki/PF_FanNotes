class Room < ApplicationRecord
  
  has_many :user_rooms
  has_many :chats
  belongs_to :request
  
end
