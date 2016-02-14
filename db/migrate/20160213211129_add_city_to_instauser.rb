class AddCityToInstauser < ActiveRecord::Migration
  def change
    add_column :instausers, :city, :string
  end
end
