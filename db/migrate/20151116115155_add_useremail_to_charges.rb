class AddUseremailToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :useremail, :string
  end
end
