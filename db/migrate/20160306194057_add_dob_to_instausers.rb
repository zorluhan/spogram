class AddDobToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :dob, :date
  end
end
