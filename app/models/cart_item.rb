class CartItem < ApplicationRecord
  belongs_to :end_user
  belongs_to :sale
end
