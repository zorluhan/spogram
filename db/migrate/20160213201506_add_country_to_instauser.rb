class AddCountryToInstauser < ActiveRecord::Migration
  def change
    add_column :instausers, :country, :string
  end
end
