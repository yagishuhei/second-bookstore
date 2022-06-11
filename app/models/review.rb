class Review < ApplicationRecord
  belongs_to :end_user
  belongs_to :book
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  #Favoriteテーブルにend_userIDが存在するか？
  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
