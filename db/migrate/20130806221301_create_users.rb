class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :salt
      t.string :fish
   

      t.timestamps
    end
  end
end
