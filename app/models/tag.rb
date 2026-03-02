class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :shares, through: :taggings, source: :taggable, source_type: "Share"
  has_many :resources, through: :taggings, source: :taggable, source_type: "Resource"

  belongs_to :parent, class_name: "Tag", optional: true
  has_many :children, class_name: "Tag", foreign_key: :parent_id

  CATEGORIES = [
    [ "Symptom", "symptom" ],
    [ "Stage", "stage" ],
    [ "Workplace", "workplace" ],
    [ "Mental Health", "mental_health" ],
    [ "Country", "country" ]
  ].freeze

  validates :name, presence: true
  validates :category, presence: true

  scope :roots, -> { where(parent_id: nil) }
  scope :by_category, ->(cat) { where(category: cat) }

  def root?
    parent_id.nil?
  end

  def children?
    children.any?
  end
end
