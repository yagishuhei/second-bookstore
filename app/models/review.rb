class Review < ApplicationRecord
  
  belongs_to :end_user
  belongs_to :book
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_end_users, through: :favorites, source: :end_user

  enum review_status: {published: 0, draft: 1}

  validates :heading, presence: true
  validates :blog, presence: true
  validates :score, presence: true

  #Favoriteテーブルにend_userIDが存在するか？
  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
