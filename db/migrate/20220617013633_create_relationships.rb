class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower, null: false, foreign_key: { to_table: :end_users }, type: :integer
      t.references :followed, null: false, foreign_key: { to_table: :end_users }, type: :integer

      t.timestamps
    end
  end
end
