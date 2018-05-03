Rails.application.routes.draw do
  get '/tables', to: 'tables#all_tables'

  get '/tables/table/:table_name', to: 'tables#table', as: 'table'

  root 'pages#home'

  devise_for :users
  resources :profiles
  resources :pickup_requests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
