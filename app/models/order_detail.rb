class OrderDetail < ApplicationRecord

  belongs_to :sale
  belongs_to :order
end
