class AddRmvShippingCollumns < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :ship_address_id, :string
  	remove_column :subscriptions, :shipping_address_id
  	remove_column :subscriptions, :ship_id
  end
end



