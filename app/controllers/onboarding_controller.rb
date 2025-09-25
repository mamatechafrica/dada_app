class OnboardingController < ApplicationController
  before_action :set_user_profile, only: [:index, :create, :update, :complete]
  before_action :set_session_profile, only: [:start, :show, :update_step]

  def index
    # Only redirect if user is authenticated and has completed onboarding
    if user_signed_in? && @user_profile&.completed_onboarding?
      redirect_to dashboard_path
    end
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
      @session_profile.merge!(location_params_hash)
    when 'stage'
      @session_profile.merge!(stage_params_hash)
    when 'symptoms'
      @session_profile.merge!(symptoms_params_hash)
    when 'welcome'
      @session_profile[:anonymous_name] = generate_anonymous_name if @session_profile[:anonymous_name].blank?
      # Store completed onboarding data in session for later use
      session[:onboarding_completed] = true
    end

    # Store profile data in session
    session[:onboarding_profile] = @session_profile

    if @current_step == 'welcome'
      respond_to do |format|
        format.js { render 'complete_preview' }
      end
    else
      @next_step = next_step(@current_step)
      respond_to do |format|
        format.js { render 'show' }
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
    @user_profile = current_user.user_profile if user_signed_in?
  end

  def set_session_profile
    @session_profile = session[:onboarding_profile] || {}
  end

  def location_params
    params.require(:user_profile).permit(:region, :city)
  end

  def location_params_hash
    location_params.to_h
  end

  def stage_params
    params.require(:user_profile).permit(:stage)
  end

  def stage_params_hash
    stage_params.to_h
  end

  def symptoms_params
    params.require(:user_profile).permit(:symptoms)
  end

  def symptoms_params_hash
    symptoms_params.to_h
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
