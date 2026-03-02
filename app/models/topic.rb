class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :circle
  has_many :posts, dependent: :destroy

  validates :title, presence: true

  enum :status, { open: 0, closed: 1, pinned: 2 }, default: :open

  scope :recent, -> { order(created_at: :desc) }
  scope :open_topics, -> { where(status: :open) }
end
