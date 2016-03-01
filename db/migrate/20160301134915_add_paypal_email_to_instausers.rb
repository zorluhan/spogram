class AddPaypalEmailToInstausers < ActiveRecord::Migration
  def change
    add_column :instausers, :paypal_email, :string
    add_column :instausers, :send_email, :boolean, :default => true
  end
end
