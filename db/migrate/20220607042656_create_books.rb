class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.integer :end_user_id
      t.integer :isbn
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
