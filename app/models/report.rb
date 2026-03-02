class Report < ApplicationRecord
  belongs_to :user
  belongs_to :share

  enum :status, { pending: 0, reviewed: 1, resolved: 2 }, default: :pending

  REASONS = [
    [ "Inappropriate content", "inappropriate" ],
    [ "Spam", "spam" ],
    [ "Harassment", "harassment" ],
    [ "Misinformation", "misinformation" ],
    [ "Other", "other" ]
  ].freeze

  validates :reason, presence: true
  validates :user_id, uniqueness: { scope: :share_id }
end
