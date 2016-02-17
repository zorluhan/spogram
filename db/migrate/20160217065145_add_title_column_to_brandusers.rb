class AddTitleColumnToBrandusers < ActiveRecord::Migration
  def change
    add_column :brandusers, :title, :string
  end
end
