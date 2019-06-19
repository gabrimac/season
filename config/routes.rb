Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :movies, only: :index
      resources :seasons, only: %i[index show] do
        resources :episodes
      end
      resources :purchase, only: :create
      resources :contents, only: :index
      resources :libraries, only: :index
    end
  end
end
