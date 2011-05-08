Readabilify::Application.routes.draw do
  resource :home, controller: 'home'
  resources :articles

  match "/readability/callback", to: 'home#show', as: 'readability_callback'
  match "/readability/logout", to: 'home#show', as: 'readability_logout'

  root to: 'home#show'
end
