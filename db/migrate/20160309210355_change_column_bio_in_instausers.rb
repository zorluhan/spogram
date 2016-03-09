class ChangeColumnBioInInstausers < ActiveRecord::Migration
  def change
  	change_column :instausers, :bio, :text
  end
end
