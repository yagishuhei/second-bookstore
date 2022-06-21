class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :order_id
      t.integer :sale_id
      t.integer :price
      t.integer :shipping_status, default: 0

      t.timestamps
    end
  end
end
