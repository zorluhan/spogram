class AddAttachmentImageToBrandusers < ActiveRecord::Migration
  def self.up
    change_table :brandusers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :brandusers, :image
  end
end
