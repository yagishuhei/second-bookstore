class Order < ApplicationRecord
  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {incomplete: 0, complete: 1}
  belongs_to :end_user
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true
  validates :shipping_address, presence: true
  validates :shipping_name, presence: true
end
