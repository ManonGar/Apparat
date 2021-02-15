Rails.application.routes.draw do
  get 'costumes/index'
  get 'costumes/show'
  get 'costumes/new'
  get 'costumes/create'
  get 'bookings/new'
  get 'bookings/createindex'
  get 'bookings/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
