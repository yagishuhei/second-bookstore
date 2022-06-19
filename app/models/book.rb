class Book < ApplicationRecord

  belongs_to :end_user
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :sales, dependent: :destroy

end
