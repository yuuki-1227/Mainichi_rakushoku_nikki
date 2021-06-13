class RenameColumnContactsPhoneNamberPhoneNumber < ActiveRecord::Migration[5.2]
  def change
    rename_column :contacts, :phone_namber, :phone_number
  end
end
