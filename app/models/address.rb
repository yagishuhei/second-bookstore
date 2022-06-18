class Address < ApplicationRecord
 
  def address_display
    '〒'+postal_code+''+address+''+name
  end
  
  belongs_to :end_user
end
