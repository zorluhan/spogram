class AddMessageToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :message, :string
  end
end
