class OrderDetail < ApplicationRecord
  enum shipping_status: {now_buying: 0, shipping: 1, cancel: 2}
  belongs_to :sale
  belongs_to :order
end
