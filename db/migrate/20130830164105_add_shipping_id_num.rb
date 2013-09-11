class AddShippingIdNum < ActiveRecord::Migration
  def change
  		 add_column :subscriptions, :shipping_address_id, :string
  end
end
