class RemovePasswordFromInstausers < ActiveRecord::Migration
  def change
    remove_column :instausers, :password, :string
  end
end
