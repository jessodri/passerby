Rails.application.routes.draw do

  get 'messages/index'

  get 'conversations/index'

  root 'pages#home'

  devise_for :users
  resources :profiles
  resources :pickup_requests
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
