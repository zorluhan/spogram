class RemoveColumnsFromCharge < ActiveRecord::Migration
  def change
    remove_column :charges, :productname, :string
    remove_column :charges, :instalink, :string
    remove_column :charges, :instapost, :string
    remove_column :charges, :explanation, :string
  end
end
