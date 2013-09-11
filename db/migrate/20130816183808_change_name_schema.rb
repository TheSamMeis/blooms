class ChangeNameSchema < ActiveRecord::Migration
  def change

  	rename_column :users, :L_name, :last_name
  	rename_column :users, :F_name, :first_name
  end
end
