class CreateBooks < ActiveRecord::Migration[6.1]
  def change
 
    create_table :books do |t|
      
      t.references :end_user, foreign_key: true
      t.bigint :isbn
      t.string :title
      t.string :author
      t.string :publisher_name
      t.string :item_price
      t.string :item_url
      t.string :large_image_url
      t.string :medium_image_url

      t.timestamps
    end
  end
end
