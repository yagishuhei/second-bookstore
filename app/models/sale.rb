class Sale < ApplicationRecord
  enum status: {on_sale: 0, buying: 1, shipping: 2}

  belongs_to :end_user
  belongs_to :book
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :title, presence: true
  validates :introduction, presence: true
  validates :price, presence: true


  #sale_imageカラムが追加されたように扱える
  has_one_attached :sale_image
  #sale_imageが設定されない時、book-no-image.jpgをデフォルト画像としてActiveStorageに格納、その後表示。
  #サイズの変更も行う。
  def get_sale_iamge(size)
    unless sale_image.attached?
      file_path = Rails.root.join('app/assets/images/book-no-image.jpg')
      sale_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    sale_image.variant(resize:size).processed
  end

end
