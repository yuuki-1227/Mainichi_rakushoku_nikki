class ChangeColumnShoppings < ActiveRecord::Migration[5.2]
  def change
    change_column :shoppings, :buy_date, :start_time
  end
end
