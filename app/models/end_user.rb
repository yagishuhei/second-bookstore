class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #imageカラムが追加されたように扱える
  has_one_attached :image


  #imageが設定されない時、no-image.jpgをデフォルト画像としてActiveStorageに格納、その後表示。
  #サイズの変更も行う。
  def get_profile_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize:size).processed
  end
end
