class AddAuthTokenToInstaUser < ActiveRecord::Migration
  def change
    add_column :instausers, :auth_token, :string, default: nil
    add_column :instausers, :is_authenticated, :boolean, default: false
  end
end
