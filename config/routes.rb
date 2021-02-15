Rails.application.routes.draw do
  root to: 'pages#home'
  resources :costumes, only: [ :index, :new, :create, :show ] do 
    resources :bookings, only: [ :new, :create, :index, :show ]
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
