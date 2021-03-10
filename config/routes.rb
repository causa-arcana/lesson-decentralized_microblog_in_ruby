Rails.application.routes.draw do
  root to: 'home#show'

  resources :profiles, only: %i[index show] do
    resources :followers, controller: 'profiles/followers', only: :index
    resources :following, controller: 'profiles/following', only: :index
  end
end
