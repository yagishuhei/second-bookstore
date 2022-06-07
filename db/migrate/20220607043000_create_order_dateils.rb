class CreateOrderDateils < ActiveRecord::Migration[6.1]
  def change
    create_table :order_dateils do |t|

      t.timestamps
    end
  end
end
