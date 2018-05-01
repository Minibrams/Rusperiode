Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # Authentication
  get '/login', to: 'public/sessions#new'
  get '/logout', to: 'public/sessions#destroy'
  match '/auth/:provider/callback', to: 'public/sessions#create', as: :auth_login_callback, via: %i[get post]

  # Dynamic page-matching
  match '/:page', to: 'public/pages#show', via: :get
  root to: 'public/pages#show'
end
