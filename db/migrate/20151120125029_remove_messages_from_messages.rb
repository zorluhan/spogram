class RemoveMessagesFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :messages, :string
  end
end
