class Review < ApplicationRecord
  belongs_to :end_user
  belongs_to :book
end
