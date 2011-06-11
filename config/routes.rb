Readabilify::Application.routes.draw do
  resource :home, controller: 'home' do
    collection do 
      get :clean
      post :clean
    end
  end
  resources :articles do
    collection do
      post :mass_convert
    end
  end

  match "/readability/callback", to: 'home#clean', as: 'readability_callback'
  match "/readability/logout", to: 'home#clean', as: 'readability_logout'

  root to: 'home#show'
end
