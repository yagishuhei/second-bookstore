class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.references :order, foreign_key: true
      t.references :sale, foreign_key: true
      t.integer :price
      t.integer :shipping_status

      t.timestamps
    end
  end
end
