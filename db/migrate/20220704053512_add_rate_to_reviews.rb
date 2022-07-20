class AddRateToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :rate, :decimal, precision: 5, scale: 3
  end
end
