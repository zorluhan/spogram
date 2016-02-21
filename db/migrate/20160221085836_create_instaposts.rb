class CreateInstaposts < ActiveRecord::Migration
  def change
    create_table :instaposts do |t|
      t.references :instauser, :null => false
      t.string :media_thumb_url
      t.string :media_standard_url
      t.date :media_date
      t.boolean :most_liked, :default => false
      t.timestamps
    end
  end
end