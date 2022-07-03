class Sale < ApplicationRecord
  enum status: {on_sale: 0, buying: 1, shipping: 2}

  belongs_to :end_user
  belongs_to :book
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :title, presence: true
  validates :introduction, presence: true
  validates :price, presence: true


  #sale_imageカラムが追加されたように扱える
  has_one_attached :sale_image
  #拡張子を制限してエラーが出ないようにしている
  validate :sale_image_content_type, if: :was_attached?

  def sale_image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:sale_image, "の拡張子が間違ってます") unless sale_image.content_type.in?(extension)
  end

  def was_attached?
    self.sale_image.attached?
  end
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
