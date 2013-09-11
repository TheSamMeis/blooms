class ChangeAddressTable < ActiveRecord::Migration
   def change

  	rename_column :ship_adresses, :l_name, :last_name
  	rename_column :ship_adresses, :f_name, :first_name 
  	rename_column :ship_adresses, :adress2, :address2 
   	rename_table :ship_adresses, :ship_addresses

    
  end
end
