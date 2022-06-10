class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|

      t.references :sale, null: false, foreign_key: true
      t.references :end_user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
