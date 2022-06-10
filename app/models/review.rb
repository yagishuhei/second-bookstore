class Review < ApplicationRecord
  belongs_to :end_user
  belongs_to :book
  has_many :review_comments, dependent: :destroy

end
