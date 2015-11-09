class CreateInstausers < ActiveRecord::Migration
  def change
    create_table :instausers do |t|

      t.timestamps
      t.string :fullname
      t.string :username
      t.string :email
      t.string :password_digest 
      t.string :location
      t.integer :age 
      t.string :theme
      t.integer :postprice
      t.integer :averagelikes
      t.integer :averagecomments 
      t.integer :followed_by 
      t.text :profile_picture 
      t.text :recent_media_urls 

      
    end
  end
end
