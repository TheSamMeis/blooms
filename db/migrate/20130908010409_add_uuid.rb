class AddUuid < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :uuid, :string
  end
end
