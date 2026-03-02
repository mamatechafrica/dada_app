class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  layout "admin"

  def index
    @shares_count = Share.count
    @resources_count = Resource.count
    @flagged_count = Share.flagged.count
    @tags_count = Tag.count
  end

  private

  def authorize_admin!
    redirect_to "/" unless current_user.admin?
  end
end
