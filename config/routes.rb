Rails.application.routes.draw do
  root to: 'home#show'

  resources :profiles, only: :show
end
