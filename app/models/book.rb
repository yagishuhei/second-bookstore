class Book < ApplicationRecord

  belongs_to :end_user
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :sales, dependent: :destroy

   #本検索機能
  def self.looks(search, word)
    if search == "partial_match"
      @book = Book.where("name LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

end
