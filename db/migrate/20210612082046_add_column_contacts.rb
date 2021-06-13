class AddColumnContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :name, :string
    add_column :contacts, :email, :string
    add_column :contacts, :phone_namber, :string
    add_column :contacts, :subject, :integer, default: 0
    add_column :contacts, :message, :text
  end
end
