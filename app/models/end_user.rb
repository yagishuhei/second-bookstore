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
  has_many :sales, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  #外部キーも指定
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follored, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #自分がフォローしている人
  has_many :following_end_user, through: :follower, source: :followed
  #自分がフォローされている人
  has_many :follower_end_user, through: :follower, source: :follower
  
  #ユーザーをフォロー
  def follow(end_user_id)
    follower.create(followed_id: end_user_id)
  end
  
  #ユーザーのフォローを外す
  def unfollow(end_user_id)
    follower.find_by(followed_id: end_user_id).destroy
  end
  
  def following?(end_user)
    following_end_user.include?(end_user)
  end
  
  
  #ゲストログイン用にアカウントを用意
  def self.guest
    find_or_create_by!(last_name: 'ゲストユーザー', email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.last_name = 'ゲストユーザー'
    end
  end


  #profile_imageカラムが追加されたように扱える
  has_one_attached :profile_image

  #profile_imageが設定されない時、no-image.jpgをデフォルト画像としてActiveStorageに格納、その後表示。
  #サイズの変更も行う。
  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize:size).processed
  end
end