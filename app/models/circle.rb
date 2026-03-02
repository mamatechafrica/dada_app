class Circle < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :posts, through: :topics

  validates :name, presence: true

  before_create :set_slug

  def set_slug
    self.slug = name.parameterize if slug.blank?
  end

  def to_param
    slug
  end

  def members
    User.where(id: topics.select(:user_id)).or(User.where(id: posts.select(:user_id))).distinct
  end
end
