class ChangeColumnShoppings < ActiveRecord::Migration[5.2]
  def change
    change_column :shoppings, :start_time, :buy_date
  end
end
