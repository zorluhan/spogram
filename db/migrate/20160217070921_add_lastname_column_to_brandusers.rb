class AddLastnameColumnToBrandusers < ActiveRecord::Migration
  def change
    add_column :brandusers, :lastname, :string
  end
end
