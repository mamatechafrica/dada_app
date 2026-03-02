class Suggestion < ApplicationRecord
  belongs_to :circle, optional: true
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending

  validates :title, presence: true
end
