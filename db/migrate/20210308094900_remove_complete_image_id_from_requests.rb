class RemoveCompleteImageIdFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :complete_image_id, :string
  end
end
