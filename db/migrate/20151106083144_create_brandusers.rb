class CreateBrandusers < ActiveRecord::Migration
  def change
    create_table :brandusers do |t|

      t.timestamps
      t.string :fullname
      t.string :phone
      t.string :country
      t.string :password_digest
      t.string :cowebsite
      t.string :coname
      t.string :email
     
       

    end
  end
end
