class ChangeMessageTypeInMessages < ActiveRecord::Migration
    def self.up
    change_column :messages, :message, :text
  end
 
  def self.down
    change_column :messages, :message, :string
  end


end
