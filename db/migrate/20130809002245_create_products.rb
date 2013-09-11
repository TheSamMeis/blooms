class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :f_name
      t.string :l_name
      t.string :company
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :phone

      t.timestamps
    end
  end
end
