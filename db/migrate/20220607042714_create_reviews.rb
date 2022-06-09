class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.references:end_user, null: false, foreign_key: true
      #foreign_key: trueを外す
      t.references:book, null: false
      t.references:category, null: false, foreign_key: true
      t.string :heading
      t.text :blog
      t.float :score

      t.timestamps
    end
   #:bookcases がないのでmigrateできない
   #
   # add_foreign_key :bookcases, :books, colmn: :book_id, primary_key: :isbn
  end
end
