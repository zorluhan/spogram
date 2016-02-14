class RemoveCountryFromInstauser < ActiveRecord::Migration
  def change
    remove_column :instausers, :country, :string
  end
end
