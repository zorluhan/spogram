class AddIsReadToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :is_read, :boolean, default: false
  end
end
