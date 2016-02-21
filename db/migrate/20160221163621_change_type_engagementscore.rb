class ChangeTypeEngagementscore < ActiveRecord::Migration
  def change
  	change_column :instausers, :engagementscore, :float, :default => 0.0
  end
end
