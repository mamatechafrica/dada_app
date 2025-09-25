Rails.application.routes.draw do
  devise_for :users

  # Mount simple_discussion forum
  mount SimpleDiscussion::Engine => "/forum"

  # Public routes
  root "home#index"
  get "home/index"

  # Onboarding (accessible to all visitors)
  resources :onboarding, only: [ :index, :show ] do
    collection do
      get :start
      patch :update_step
    end
  end

    # Protected routes (require authentication)
    # authenticate :user do
    get "dashboard", to: "dashboard#index"

    resources :onboarding, only: [ :create, :update ] do
      collection do
        patch :complete
      end
    end
  # end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
