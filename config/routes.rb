Rails.application.routes.draw do

  get 'messages/index'

  get 'conversations/index'

  root 'pages#home'

  devise_for :users, controllers: { registrations: "registrations" }

  resources :profiles

  resources :pickup_requests do
    member do
      patch :accept
      delete :unaccept
      post :charge

    end
  end

  resources :conversations do
    resources :messages
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
