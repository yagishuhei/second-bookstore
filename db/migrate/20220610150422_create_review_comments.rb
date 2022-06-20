class CreateReviewComments < ActiveRecord::Migration[6.1]
  def change
    create_table :review_comments do |t|
      t.references :end_user, null: false, foreign_key: true, type: :integer
      t.references :review, null: false, foreign_key: true, type: :integer
      t.text :comment

      t.timestamps
    end
  end
end
