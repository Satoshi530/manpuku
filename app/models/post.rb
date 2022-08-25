class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  # post_tagsを経由して複数のタグを持てる
  has_many :tags,through: :post_tags

  validates :user_id, presence: true
  validates :restaurant_name, presence: true
  validates :description, presence: true,length:{maximum:500}
  validates :rate, presence: true

  def get_image
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/gazo.jpg')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    images
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tag(sent_tags)
    # 既存のタグがあれば全て名前で配列
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # current_tagから送られてきたタグを除いたタグをold_tagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnew_tagとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def self.looks(word)
    if word != ""
      #where$LIKEで曖昧検索が可能
      Post.where('restaurant_name LIKE ?', '%'+word+'%')
    else
      Post.all
    end
  end
end
