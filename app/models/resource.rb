class Resource < ApplicationRecord
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  enum :resource_type, { article: 0, toolkit: 1, template: 2, video: 3, audio: 4 }, default: :article
  enum :access_level, { free: 0, registered: 1, premium: 2 }, default: :free

  validates :title, presence: true

  CONTENT_TYPES = [
    [ "Article", "article" ],
    [ "Toolkit", "toolkit" ],
    [ "Template", "template" ],
    [ "Video", "video" ],
    [ "Audio", "audio" ]
  ].freeze

  ACCESS_LEVELS = [
    [ "Free", "free" ],
    [ "Registered", "registered" ],
    [ "Premium", "premium" ]
  ].freeze

  scope :published, -> { where.not(published_at: nil) }
  scope :featured, -> { where(featured: true) }
  scope :sorted_newest, -> { order(published_at: :desc) }
  scope :sorted_featured, -> { order(featured: :desc, published_at: :desc) }
end
