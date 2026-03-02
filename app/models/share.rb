class Share < ApplicationRecord
  belongs_to :user
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :reports, as: :reportable, dependent: :destroy

  enum :visibility, { public: 1, private: 2 }, prefix: true
  enum :status, { draft: 0, published: 1, flagged: 2 }, default: :draft

  TYPES = [
    [ "Text", "text" ],
    [ "Image", "image" ],
    [ "Video", "video" ]
  ].freeze

  validates :share_type, presence: true
  validates :visibility, presence: true

  scope :published, -> { where(status: :published) }
  scope :public_shares, -> { published.where(visibility: :public) }
  scope :flagged, -> { where(status: :flagged) }

  def anonymous?
    anonymous && visibility_public?
  end

  def visibility_public?
    visibility == "public"
  end

  def flag_if_reported!
    if reports.count >= 3
      update(status: :flagged)
    end
  end
end
