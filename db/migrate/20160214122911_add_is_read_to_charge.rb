class AddIsReadToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :is_read, :boolean, default: false
  end
end
