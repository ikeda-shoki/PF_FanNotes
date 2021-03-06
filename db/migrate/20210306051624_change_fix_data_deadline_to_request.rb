class ChangeFixDataDeadlineToRequest < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :deadline, :date
  end
end
