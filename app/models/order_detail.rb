class OrderDetail < ApplicationRecord
  enum shipping_status: {cancel: 0, shipping: 1, now_buying: 2}
  belongs_to :sale
  belongs_to :order
end
