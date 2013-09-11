class AddCollumnsToShipAddresses < ActiveRecord::Migration
  def change

  	  add_column :ship_addresses, :company, :string
  	  add_column :ship_addresses, :city, :string
  	  add_column :ship_addresses, :state, :string
  	  add_column :ship_addresses, :postalcode, :string
  end
end
