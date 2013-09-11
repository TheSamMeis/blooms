class AddSubscriptionsTable < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :user_id
      t.string :subscription_type
      t.string :subscription_frequency
      t.string :subscription_status
      t.string :first_name_shipping
      t.string :last_name_shipping
      t.string :company_shipping
      t.string :address1_shipping
      t.string :address2_shipping    
      t.string :city_shipping
      t.string :state_shipping
      t.string :postal_code_shipping
      t.string :country_shipping

      t.timestamps
 
  end
end
end
