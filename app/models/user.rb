class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #ユーザーがいいねした投稿の情報を取得する
  has_many :favorite_posts, through: :favorites, source: :post
  # 自分がフォローする側の関係
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  #自分がフォローされる側の関係
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  validates :email, presence:true
  validates :name, presence:true, length: {minimum: 2, maximum: 20 }
  validates :name, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.looks(word)
    if word != ""
      User.where('name LIKE ?', '%'+word+'%')
    else
      User.all
    end
  end

  #退会済みアカウントでログインできないように制限
  def active_for_authentication?
  #is_deletedがfalseならtrueを返すように設定
    super && (is_deleted == false)
  end
end
