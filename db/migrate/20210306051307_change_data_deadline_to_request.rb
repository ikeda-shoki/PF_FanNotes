class ChangeDataDeadlineToRequest < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :deadline, :datatime
  end
end
