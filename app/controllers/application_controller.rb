class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_onboarding, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
  
  def redirect_to_onboarding
    return unless user_signed_in?
    return if devise_controller?
    return if controller_name == 'onboarding' || controller_name == 'home'
    return if current_user.onboarding_completed?
    
    redirect_to onboarding_index_path, notice: "Welcome! Let's get to know you better."
  end
end
