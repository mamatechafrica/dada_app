class UserProfile < ApplicationRecord
  belongs_to :user
  
  validates :user, presence: true
  
  # Generate anonymous name for privacy
  before_create :generate_anonymous_name
  
  def pathway_type
    return 'pre-menopause' if stage == 'pre-menopause'
    return 'perimenopause' if stage == 'perimenopause'
    return 'menopause' if stage == 'menopause'
    return 'post-menopause' if stage == 'post-menopause'
    'exploring' # default for users still determining their stage
  end
  
  def symptoms_list
    symptoms&.split(',')&.map(&:strip) || []
  end
  
  def preferences_list
    preferences&.split(',')&.map(&:strip) || []
  end
  
  private
  
  def generate_anonymous_name
    names = ['Sister', 'Mama', 'Auntie']
    colors = ['Sunrise', 'Ocean', 'Forest', 'Moonlight', 'Golden', 'Ruby', 'Emerald']
    self.anonymous_name ||= "#{names.sample} #{colors.sample}"
  end
end
