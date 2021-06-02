class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.integer :shopping_id
      t.string :name
      t.integer :amount
      t.integer :price

      t.timestamps
    end
  end
end
