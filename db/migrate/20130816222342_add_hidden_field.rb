class AddHiddenField < ActiveRecord::Migration
  def change
  	 add_column :ship_addresses, :user_id, :string
  end
end
