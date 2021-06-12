class RenameColumnShoppings < ActiveRecord::Migration[5.2]
  def change
    rename_column :shoppings, :buy_date, :start_time

    change_column :shoppings, :start_time, :date
  end
end
