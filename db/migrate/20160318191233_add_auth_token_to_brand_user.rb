class AddAuthTokenToBrandUser < ActiveRecord::Migration
  def change
    add_column :brandusers, :auth_token, :string, default: nil
    add_column :brandusers, :is_authenticated, :boolean, default: false
  end
end
