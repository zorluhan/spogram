class RemovePasswordDigestFromInstausers < ActiveRecord::Migration
  def change
    remove_column :instausers, :password_digest, :string
  end
end
