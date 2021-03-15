class AddRequestToRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :request, foreign_key: true
  end
end
