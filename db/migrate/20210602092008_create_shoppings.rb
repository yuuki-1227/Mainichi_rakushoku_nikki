class CreateShoppings < ActiveRecord::Migration[5.2]
  def change
    create_table :shoppings do |t|
      t.integer :end_user_id
      t.integer :total_price
      t.string :image
      t.date :buy_date

      t.timestamps
    end
  end
end
