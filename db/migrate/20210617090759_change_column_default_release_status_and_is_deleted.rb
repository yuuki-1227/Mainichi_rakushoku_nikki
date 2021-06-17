class ChangeColumnDefaultReleaseStatusAndIsDeleted < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :is_deleted, from: true, to: false
    change_column_default :posts, :release_status, from: true, to: false
  end
end
