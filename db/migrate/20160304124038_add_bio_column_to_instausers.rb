class AddBioColumnToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :bio, :string
  end
end
