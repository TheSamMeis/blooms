class ChangeAddressTable < ActiveRecord::Migration
   def change

  	rename_column :ship_addresses, :l_name, :last_name
  	rename_column :ship_addresses, :f_name, :first_name 
 

    
  end
end
