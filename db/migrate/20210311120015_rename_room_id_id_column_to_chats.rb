class RenameRoomIdIdColumnToChats < ActiveRecord::Migration[5.2]
  def change
    rename_column :chats, :room_id_id, :room_id
  end
end
