class CartItem < ApplicationRecord
  belongs_to :end_user
  has_many :sales, dependent: :destroy
end
