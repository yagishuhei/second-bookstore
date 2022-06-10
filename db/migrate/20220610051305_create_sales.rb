class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|

      t.references :book, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.text :introduction
      t.integer :price
      t.boolean :is_active

      t.timestamps
    end
  end
end
