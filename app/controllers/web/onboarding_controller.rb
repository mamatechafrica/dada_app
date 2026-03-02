module Web
  class OnboardingController < ApplicationController
    before_action :initialize_onboarding
    before_action :apply_onboarding_data, if: :user_signed_in?

    def step1; end

    def step2
      session[:stage] = params[:stage] if params[:stage]
      @selected_stage = session[:stage]
    end

    def step3
      session[:stage] = params[:stage] if params[:stage]

      if session[:stage] == "Ally"
        session[:symptoms] = []
        redirect_to web_onboarding_step4_path and return
      end

      session[:symptoms] = params[:symptoms] if params[:symptoms]
      @selected_symptoms = session[:symptoms]
    end

    def step4
      session[:symptoms] = params[:symptoms] if params[:symptoms]
      @selected_country = session[:country]
    end

    def step5
      session[:country] = params[:country] if params[:country]

      @summary = {
        stage: session[:stage],
        symptoms: session[:symptoms],
        country: session[:country]
      }
    end

    def submit
      session[:stage] = params[:stage] if params[:stage]
      session[:country] = params[:country] if params[:country]

      if session[:stage] == "Ally"
        session[:symptoms] = []
        save_onboarding_to_user if user_signed_in?
        redirect_to web_contents_path(stage: "Ally"), notice: "Welcome, ally! Here are some ways to support." and return
      end

      session[:symptoms] = params[:symptoms] if params[:symptoms]

      save_onboarding_to_user if user_signed_in?

      case session[:stage]
      when "Perimenopause", "Menopause", "Post-menopause"
        redirect_to web_contents_path(stage: session[:stage]), notice: "Welcome! We've curated resources for you." and return
      when "Not sure"
        redirect_to web_contents_path(stage: "General"), notice: "Explore general guidance to help you discover your path." and return
      else
        redirect_to web_home_index_path, alert: "Something went wrong. Please try again."
      end
    end

    private

    def initialize_onboarding
      session[:stage] ||= nil
      session[:symptoms] ||= []
      session[:country] ||= nil
    end

    def save_onboarding_to_user
      return unless current_user

      symptoms_value = session[:symptoms].is_a?(Array) ? session[:symptoms].join(",") : session[:symptoms]

      current_user.update(
        stage: session[:stage],
        symptoms: symptoms_value,
        country: session[:country]
      )
    end

    def apply_onboarding_data
      return unless session[:stage] || session[:country]
      return if current_user.stage.present?

      save_onboarding_to_user
    end
  end
end
