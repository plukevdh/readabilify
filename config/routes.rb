Readabilify::Application.routes.draw do
  devise_for :users

  resource :home, controller: 'home' do
    get :register
  end

  root to: 'home#show'
end
