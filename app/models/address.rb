class Address < ApplicationRecord
  belongs_to :end_user

  def address_display
    '〒'+postal_code+''+address+''+name
  end

  validates :postal_code, presence: true,length:{maximum:10}
  validates :address, presence: true
  validates :name, presence: true

end

