class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.references:end_user, null: false, foreign_key: true
     
      t.references:book, null: false
      t.references:category, foreign_key: true
      t.string :heading
      t.text :blog
      t.float :score

      t.timestamps
    end
    
  end
end
