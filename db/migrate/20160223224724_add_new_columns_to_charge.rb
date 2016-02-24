class AddNewColumnsToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :product_name, :string, default: ''
    add_column :charges, :product_link, :string, default: ''
    add_column :charges, :product_description, :text

    add_column :charges, :post_description, :text
    add_column :charges, :suggested_caption, :text
    add_column :charges, :hash_tags, :text
    add_column :charges, :user_names, :text

    add_column :charges, :earliest_post_date, :date
    add_column :charges, :last_post_date, :date

    add_column :charges, :instagram_link, :string, default: ''
  end
end
