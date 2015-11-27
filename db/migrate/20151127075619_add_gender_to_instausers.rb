class AddGenderToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :gender, :string
  end
end
