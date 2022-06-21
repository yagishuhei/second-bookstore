class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|

      t.integer :end_user_id
      t.integer :book_id
      t.string :title
      t.text :introduction
      t.integer :price
      t.integer :status

      t.timestamps
    end
  end
end
