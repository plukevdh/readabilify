Readabilify::Application.routes.draw do
  devise_for :users

  resource :home, controller: 'home'
  resources :articles

  match "/readability/callback", to: 'home#show', as: 'readability_callback'

  root to: 'home#show'
end
