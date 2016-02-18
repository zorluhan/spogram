class AddLastnameToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :lastname, :string
  end
end
