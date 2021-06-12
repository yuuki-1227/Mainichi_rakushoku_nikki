class RenameColumnPostsDateStartTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :date, :start_time
  end
end
