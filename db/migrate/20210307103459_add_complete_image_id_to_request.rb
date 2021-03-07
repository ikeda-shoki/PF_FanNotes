class AddCompleteImageIdToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :complete_image_id, :string
  end
end
