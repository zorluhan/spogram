class AddDateOfBirthToInstauser < ActiveRecord::Migration
  def change
    add_column :instausers, :date_of_birth, :date
  end
end
