class AddFirstnameToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :firstname, :string
  end
end
