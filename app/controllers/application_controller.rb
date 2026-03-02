class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!, unless: :public_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :apply_onboarding_data_after_sign_in
  allow_browser versions: :modern

  private

  def public_controller?
    controller_path.starts_with?("web/contents")
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :country, :stage, :symptoms, :profile_photo ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :country, :stage, :symptoms, :profile_photo ])
  end

  def apply_onboarding_data_after_sign_in
    return unless user_signed_in?
    return unless current_user.stage.nil?
    return unless session[:stage] || session[:country]

    symptoms_value = session[:symptoms].is_a?(Array) ? session[:symptoms].join(",") : session[:symptoms]

    current_user.update(
      stage: session[:stage],
      symptoms: symptoms_value,
      country: session[:country]
    )
  end
end
