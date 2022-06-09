class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    #idを勝手につけない
    create_table :books, id: false do |t|
      t.references :end_user, null: false, foreign_key: true
      #isbnを主キーにする
      t.bigint :isbn, null: false, primary_key: true
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
