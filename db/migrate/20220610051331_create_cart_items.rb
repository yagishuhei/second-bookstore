class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      
      t.references :sale, foreign_key: true
      t.references :end_user, foreign_key: true
      t.timestamps
    end
  end
end
