class RenameProfileImageColomnToEndUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :end_users, :profile_image, :profile_image_id
    rename_column :posts, :image, :image_id
    rename_column :shoppings, :image, :image_id
  end
end
