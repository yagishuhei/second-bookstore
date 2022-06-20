class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.references :end_user, null: false, foreign_key: true, type: :integer
      t.string :postal_code
      t.string :shipping_address
      t.string :shipping_name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method
      t.integer :status

      t.timestamps
    end
  end
end
