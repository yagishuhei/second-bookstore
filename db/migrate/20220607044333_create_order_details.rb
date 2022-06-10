class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.references :order, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true
      t.integer :price
      t.integer :shipping_status

      t.timestamps
    end
  end
end
