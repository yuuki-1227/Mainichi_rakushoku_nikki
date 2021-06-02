class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.integer :end_user_id
      t.integer :post_id
      t.text :comment

      t.timestamps
    end
  end
end
