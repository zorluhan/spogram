class AddFirstnameColumnToBrandusers < ActiveRecord::Migration
  def change
    add_column :brandusers, :firstname, :string
  end
end
