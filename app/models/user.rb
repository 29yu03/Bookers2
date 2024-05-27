class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
 has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, message: ' is too short (minimum is 2 characters)'}
  validates :name, length: { maximum: 20, message: ' is too long (maximum is 20 characters)'}
  validates :name, presence: true
  validates :introduction, length: {maximum: 50, message: ' is too long (maximum is 50 characters)'}
  validates :name, uniqueness: true

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [70, 70]).processed
  end

  # 他のユーザーをフォローする
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # フォローを解除する
  def unfollow(other_user)
    following.delete(other_user)
  end

  # ユーザーが特定のユーザーをフォローしているかどうかを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
