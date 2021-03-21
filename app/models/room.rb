class Room < ApplicationRecord

  belongs_to :request
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end
