class Book < ApplicationRecord

  belongs_to :end_user
  belongs_to :category
  has_many :reviews, dependent: :destroy

  has_many :sales, dependent: :destroy

  #book_imageカラムが追加されたように扱える
  has_one_attached :book_image


  #book_imageが設定されない時、book-no-image.jpgをデフォルト画像としてActiveStorageに格納、その後表示。
  #サイズの変更も行う。
  def get_book_iamge(size)
    unless book_image.attached?
      file_path = Rails.root.join('app/assets/images/book-no-image.jpg')
      book_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    book_image.variant(resize:size).processed
  end

end
