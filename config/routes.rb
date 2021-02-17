Rails.application.routes.draw do
  root to: 'pages#home'
  resources :costumes do
    resources :bookings, only: [ :new, :create, :index, :show]
  end
    resources :bookings, only: :destroy
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboard#dashboard'
end

