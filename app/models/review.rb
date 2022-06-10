class Review < ApplicationRecord
  belongs_to :end_user
  belongs_to :book
  has_many :reviews, dependent: :destroy

end
