class RemoveCityFromInstauser < ActiveRecord::Migration
  def change
    remove_column :instausers, :city, :string
  end
end
