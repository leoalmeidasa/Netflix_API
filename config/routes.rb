# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'netflixes/published'
      get 'netflixes/genre'
      get 'netflixes/country'
      post 'netflixes/upload'
      resources :netflixes
      root to: 'netflixes#index'
    end
  end
end
