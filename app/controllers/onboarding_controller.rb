class OnboardingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile
  
  def index
    redirect_to dashboard_path if @user_profile.completed_onboarding?
  end

  def create
    if @user_profile.update(profile_params)
      redirect_to onboarding_index_path, notice: 'Your information has been saved.'
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  def update
    if @user_profile.update(profile_params)
      redirect_to onboarding_index_path, notice: 'Your information has been saved.'
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  def complete
    if @user_profile.update(completed_onboarding: true)
      redirect_to dashboard_path, notice: 'Welcome to your personalized Dada experience!'
    else
      redirect_to onboarding_index_path, alert: 'Please complete all required fields.'
    end
  end

  private

  def set_user_profile
    @user_profile = current_user.user_profile
  end

  def profile_params
    params.require(:user_profile).permit(:stage, :symptoms, :preferences, :region, :language)
  end
end
