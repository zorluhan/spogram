class AddComsizeToBrandusers < ActiveRecord::Migration
  def change
    add_column :brandusers, :comsize, :string
  end
end
