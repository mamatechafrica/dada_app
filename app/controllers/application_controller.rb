class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!, unless: :public_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  private

  def public_controller?
    controller_path.starts_with?("web/contents")
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
