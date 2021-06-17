class ChangeColumnReleaseStatusAndIsDeleted < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :is_deleted, to: false
    change_column_default :posts, :release_status, to: false
  end
end
