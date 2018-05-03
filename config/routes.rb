Rails.application.routes.draw do
  get '/tables', to: 'tables#all_tables'

  get '/tables/table/:table_name', to: 'tables#table', as: 'table'

  root 'pages#home'

  devise_for :users

  get '/profiles', to: 'profiles#index'
  post '/profiles', to: 'profiles#create'
  
  get '/profiles/new', to: 'profiles#new'
  get '/profiles/:id/show', to: 'profiles#show', as: 'show'



  get '/profiles/:id/edit/', to: 'profiles#edit', as: 'edit'
  patch '/profiles/:id/', to: 'profiles#update', as: 'update'

  delete '/profiles/:id/edit/', to: 'profiles#destroy', as: 'delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
