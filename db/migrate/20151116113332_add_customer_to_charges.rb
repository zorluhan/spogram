class AddCustomerToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :customer, :string
  end
end
