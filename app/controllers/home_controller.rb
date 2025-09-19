class HomeController < ApplicationController
  # skip_before_action :redirect_to_onboarding

  def index
    # Safely handle case where database might not be fully seeded
    @featured_stories = Story.where(verified: true).limit(3).to_a
  rescue ActiveRecord::StatementInvalid => e
    # Handle case where verified column might not exist
    Rails.logger.error "Error querying stories: #{e.message}"
    @featured_stories = []
  end
end
