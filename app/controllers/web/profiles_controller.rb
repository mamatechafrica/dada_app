module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
      @user = current_user
      @shares = current_user.shares.order(created_at: :desc)
    end

    def update
      @user = current_user

      if @user.update(user_params)
        redirect_to web_profile_path, notice: "Profile updated successfully!"
      else
        @shares = current_user.shares.order(created_at: :desc)
        render :show, alert: "Failed to update profile."
      end
    end

    private

    def user_params
      permitted = params.require(:user).permit(:name, :country, :stage, :profile_photo)
      symptoms = params[:user][:symptoms]
      permitted[:symptoms] = symptoms.is_a?(Array) ? symptoms.reject(&:blank?).join(",") : symptoms
      permitted
    end
  end
end
