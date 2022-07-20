class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_end_users, through: :favorites, source: :review
  has_many :sales, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  #外部キーも指定
  #has_many :relationships, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #自分がフォローしている人=自分にフォロされた人(source)
  has_many :following_end_user, through: :follower, source: :followed
  #自分がフォローされている人=自分をフォロした人(source)
  has_many :follower_end_user, through: :followed, source: :follower


  def following?(end_user)
    following_end_user.include?(end_user)
  end

  #ゲストログイン用にアカウントを用意

  def self.guest
    find_or_create_by!(last_name: 'ゲスト', first_name: 'ユーザー', email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.last_name = 'ゲスト'
      end_user.first_name = 'ユーザー'
    end
  end

  #profile_imageカラムが追加されたように扱える
  has_one_attached :profile_image
  #拡張子を制限してエラーが出ないようにしている
  validate :profile_image_content_type, if: :was_attached?

  def profile_image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:profile_image, "の拡張子が間違ってます") unless profile_image.content_type.in?(extension)
  end

  def was_attached?
    self.profile_image.attached?
  end
  #profile_imageが設定されない時、no-image.jpgをデフォルト画像としてActiveStorageに格納、その後表示。
  #サイズの変更も行う。
  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    profile_image.variant(resize: size).processed
  end
end