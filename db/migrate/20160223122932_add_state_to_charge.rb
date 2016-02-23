class AddStateToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :state, :string

    add_index :charges, :state
  end
end
