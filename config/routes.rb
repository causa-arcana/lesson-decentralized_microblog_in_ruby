Rails.application.routes.draw do
  root to: 'home#show'

  resources :profiles, only: %i[index show]
end
