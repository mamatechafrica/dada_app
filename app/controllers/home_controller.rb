class HomeController < ApplicationController
  skip_before_action :redirect_to_onboarding
  
  def index
    @featured_stories = Story.verified.limit(3)
  end
end
