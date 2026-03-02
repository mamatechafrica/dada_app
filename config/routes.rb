Rails.application.routes.draw do
  devise_for :users

  namespace :web do
    get "theme_preview/index"
    get "onboarding/step1", to: "onboarding#step1"
    get "onboarding/step2", to: "onboarding#step2"
    get "onboarding/step3", to: "onboarding#step3"
    get "onboarding/step4", to: "onboarding#step4"
    get "onboarding/step5", to: "onboarding#step5"
    post "onboarding/submit", to: "onboarding#submit"
    get "theme_preview", to: "theme_preview#index"
    get "/profile", to: "profiles#show", as: :profile
    patch "/profile", to: "profiles#update"
    get "chatbot", to: "chatbot#index", as: :chatbot

    resources :shares do
      member do
        post :report
      end
    end
  end

  # Circles (Forum)
  get "/web/circles", to: redirect("/circles")
  get "/circles", to: "web/circles#index"
  get "/circles/:slug", to: "web/circles#show", as: :circle
  get "/circles/:slug/new_topic", to: "web/circles#new_topic", as: :new_topic_circle
  post "/circles/:slug/create_topic", to: "web/circles#create_topic", as: :create_topic_circle
  get "/circles/:slug/topic/:topic_id", to: "web/circles#topic", as: :circle_topic
  post "/circles/:slug/topic/:topic_id/reply", to: "web/circles#reply", as: :circle_topic_reply
  post "/circles/:slug/suggestions", to: "web/suggestions#create", as: :circle_suggestions
  post "/suggestions", to: "web/suggestions#create", as: :suggestions

  get "home/index"
  root "home#index"

  # UGC - User Generated Content (Shares)
  get "/content", to: "web/shares#index"
  get "/content/:id", to: "web/shares#show"

  # Resources - Admin Generated Content
  get "/resources", to: "web/resources#index"
  get "/resources/:id", to: "web/resources#show"

  # Admin
  namespace :admin do
    get "", to: "dashboard#index"
    resources :resources
    get :moderation, to: "moderation#index"
    post "/shares/:id/approve", to: "moderation#approve", as: :approve_share
    post "/shares/:id/unpublish", to: "moderation#unpublish", as: :unpublish_share
    post "/shares/:id/destroy", to: "moderation#destroy", as: :destroy_share
    post "/reports/:id/resolve", to: "moderation#resolve_report", as: :resolve_report
    get :suggestions, to: "suggestions#index"
    post "/suggestions/:id/approve", to: "suggestions#approve", as: :approve_suggestion
    post "/suggestions/:id/reject", to: "suggestions#reject", as: :reject_suggestion
    post "/suggestions/:id/create_circle", to: "suggestions#create_circle", as: :create_circle_from_suggestion
  end

  # Tags API
  resources :tags, only: [] do
    collection do
      get :search
    end
  end
end
