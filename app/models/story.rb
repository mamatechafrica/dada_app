class Story < ApplicationRecord
  validates :title, :content, :author_name, :author_location, presence: true
  validates :author_age, presence: true, numericality: { greater_than: 0 }
  
  scope :verified, -> { where(verified: true) }
  scope :by_stage, ->(stage) { where(stage: stage) if stage.present? }
  scope :by_region, ->(region) { where(region: region) if region.present? }
  
  def tags_list
    tags&.split(',')&.map(&:strip) || []
  end
  
  def tags_list=(tag_array)
    self.tags = tag_array.join(', ')
  end
  
  def author_display
    "#{author_name} • #{author_location} • Age #{author_age}"
  end
end
