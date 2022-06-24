class CreateReviewComments < ActiveRecord::Migration[6.1]

  def change
    create_table :review_comments do |t|

      t.integer :end_user_id
      t.integer :review_id
      t.text :comment

      t.timestamps
    end
  end
end

