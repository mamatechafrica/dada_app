class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user_profile = current_user.user_profile
    @personalized_stories = Story.verified
                                 .by_stage(@user_profile.stage)
                                 .by_region(@user_profile.region)
                                 .limit(3)
    
    # Fallback to general stories if no personalized ones found
    @personalized_stories = Story.verified.limit(3) if @personalized_stories.empty?
  end
end
