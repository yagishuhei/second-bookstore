class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :end_user_id
      t.integer :book_id
      t.string :heading
      t.text :blog
      t.float :score
      t.integer :review_status

      t.timestamps
    end

  end
end
