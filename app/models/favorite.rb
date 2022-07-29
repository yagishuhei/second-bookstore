class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :review

  validates_uniqueness_of :review_id, scope: :end_user_id
end
