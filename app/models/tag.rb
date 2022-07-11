class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  # post_tags経由で複数の投稿を持てる
  has_many :posts,through: :post_tags
  validates :name, uniqueness: true, presence: true

  def self.looks(word)
    if word != ""
      Tag.where(name: word)
    else
      Tag.all
    end
  end
end
