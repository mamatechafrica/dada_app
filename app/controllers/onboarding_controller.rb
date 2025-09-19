class OnboardingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile

  def index
    redirect_to dashboard_path if @user_profile.completed_onboarding?
  end

  def start
    @current_step = params[:step] || 'location'
    
    respond_to do |format|
      format.js # Will render start.js.erb
    end
  end

  def show
    @current_step = params[:step] || 'location'
    
    respond_to do |format|
      format.js # Will render show.js.erb
    end
  end

  def update_step
    @current_step = params[:step]
    
    case @current_step
    when 'location'
      @user_profile.assign_attributes(location_params)
    when 'stage'
      @user_profile.assign_attributes(stage_params)
    when 'symptoms'
      @user_profile.assign_attributes(symptoms_params)
    when 'welcome'
      @user_profile.assign_attributes(completed_onboarding: true)
      @user_profile.anonymous_name = generate_anonymous_name if @user_profile.anonymous_name.blank?
    end

    if @user_profile.save
      @next_step = next_step(@current_step)
      
      respond_to do |format|
        if @current_step == 'welcome'
          format.js { render 'complete' }
        else
          format.js { render 'show' }
        end
      end
    else
      respond_to do |format|
        format.js { render 'error' }
      end
    end
  end

  def create
    if @user_profile.update(profile_params)
      redirect_to onboarding_index_path, notice: "Your information has been saved."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @user_profile.update(profile_params)
      redirect_to onboarding_index_path, notice: "Your information has been saved."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def complete
    if @user_profile.update(completed_onboarding: true)
      redirect_to dashboard_path, notice: "Welcome to your personalized Dada experience!"
    else
      redirect_to onboarding_index_path, alert: "Please complete all required fields."
    end
  end

  private

  def set_user_profile
    @user_profile = current_user.user_profile
  end

  def location_params
    params.require(:user_profile).permit(:region, :city)
  end

  def stage_params
    params.require(:user_profile).permit(:stage)
  end

  def symptoms_params
    params.require(:user_profile).permit(:symptoms)
  end

  def profile_params
    params.require(:user_profile).permit(:stage, :symptoms, :preferences, :region, :language, :city)
  end

  def next_step(current_step)
    case current_step
    when 'location'
      'stage'
    when 'stage'
      'symptoms'
    when 'symptoms'
      'welcome'
    else
      'complete'
    end
  end

  def generate_anonymous_name
    names = ["Sister", "Mama", "Auntie"]
    colors = ["Sunrise", "Ocean", "Forest", "Moonlight", "Golden", "Ruby", "Emerald"]
    "#{names.sample} #{colors.sample}"
  end
end
