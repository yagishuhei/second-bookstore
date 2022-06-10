class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|

      t.references :end_user, foreign_key: true
      t.string :name
      t.string :postal_code
      t.string :address
      t.timestamps
    end
  end
end
