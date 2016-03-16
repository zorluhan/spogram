class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :username
      t.string :uid
      t.integer :branduser_id
      t.string :token
      t.string :secret
      t.timestamps
    end
  end
end
