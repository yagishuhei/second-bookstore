class CreateBooks < ActiveRecord::Migration[6.1]
  def change

    create_table :books do |t|

      t.integer :end_user_id
      t.integer :category_id
      t.bigint :isbn
      t.string :title
      t.string :author
      t.string :publisher_name
      t.text :item_caption
      t.string :item_url
      t.string :large_image_url
      t.string :medium_image_url

      t.timestamps
    end
  end
end