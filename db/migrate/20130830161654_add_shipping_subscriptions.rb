class AddShippingSubscriptions < ActiveRecord::Migration
  def change
  	 add_column :subscriptions, :ship_id, :string
  end
end
