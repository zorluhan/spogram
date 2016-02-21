class DisabledToInstauser < ActiveRecord::Migration
  def change
  	add_column :instausers, :disabled, :boolean, :default => true
  	add_column :instaposts, :likes_counts, :integer, :default => 0
  end
end
