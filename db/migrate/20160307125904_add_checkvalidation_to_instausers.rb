class AddCheckvalidationToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :checkvalidation, :string
  end
end
