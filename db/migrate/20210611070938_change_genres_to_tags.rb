class ChangeGenresToTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :genres, :is_deleted, :boolean

    rename_table :genres, :tags
  end
end
