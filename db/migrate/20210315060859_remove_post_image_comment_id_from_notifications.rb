class RemovePostImageCommentIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :post_image_comment_id, :integer
  end
end
