class CreateMessages < ActiveRecord::Migration
  def change
 

    create_table :messages do |t|


      t.string :messages
      t.integer :sender 
      t.references :instauser
      t.references :branduser  	
      t.timestamps



    end


  end
end
