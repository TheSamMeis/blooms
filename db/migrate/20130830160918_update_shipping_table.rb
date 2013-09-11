class UpdateShippingTable < ActiveRecord::Migration
  def change

  	remove_column :subscriptions, :first_name_shipping
   	remove_column :subscriptions, :last_name_shipping
    remove_column :subscriptions, :company_shipping
    remove_column :subscriptions, :address1_shipping
    remove_column :subscriptions, :address2_shipping
    remove_column :subscriptions, :city_shipping
    remove_column :subscriptions, :state_shipping
    remove_column :subscriptions, :postal_code_shipping
    remove_column :subscriptions, :country_shipping

     add_column :subscriptions, :start_date, :date


  end
end
