class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  # post_tags経由で複数の投稿を持てる
  has_many :posts,through: :post_tags
  validates :name, uniqueness: true, presence: true
end
