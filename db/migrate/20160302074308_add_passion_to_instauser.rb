class AddPassionToInstauser < ActiveRecord::Migration
  def change
    add_column :instausers, :passion, :string
  end
end
