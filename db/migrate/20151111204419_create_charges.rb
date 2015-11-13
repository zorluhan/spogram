class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|

      t.timestamps
      t.string :explanation 
      t.string :instapost
      t.string :instalink
      t.string :productname
      t.string :status 
       

      t.belongs_to :instauser, index: true 
	  t.belongs_to :branduser, index: true
     
    end
  end
end
