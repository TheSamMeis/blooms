class AddNextShipment < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :next_shipment, :date
  end
end
