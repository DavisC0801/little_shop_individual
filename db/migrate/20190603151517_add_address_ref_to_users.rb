class AddAddressRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :address, foreign_key: true
    remove_column :users, :address, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :zip, :string
  end
end
