class AddCountry < ActiveRecord::Migration
  def change
  	  add_column :ship_addresses, :country, :string
  end
end
