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
      t.string :role
      t.integer :postprice
      t.string :company
       

    end
  end
end
