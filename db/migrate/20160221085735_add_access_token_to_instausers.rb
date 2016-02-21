class AddAccessTokenToInstausers < ActiveRecord::Migration
  def change
  	add_column :instausers, :access_token, :string
  	add_column :instausers, :engagementscore, :integer, :default => 0
  	add_column :instausers, :last_updated, :datetime
  end
end
