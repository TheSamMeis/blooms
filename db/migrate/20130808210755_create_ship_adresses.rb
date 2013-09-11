class CreateShipAddresses < ActiveRecord::Migration
  def change
    create_table :ship_addresses do |t|
      t.string :f_name
      t.string :l_name
      t.string :address1
      t.string :address2

      t.timestamps
    end
  end
end
