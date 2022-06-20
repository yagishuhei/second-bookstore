class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|

      t.references :end_user, null: false, foreign_key: true, type: :integer
      t.references :book, null: false, foreign_key: true, type: :integer
      t.text :introduction
      t.integer :price
      t.boolean :is_active, default: false

      t.timestamps
    end
  end
end
