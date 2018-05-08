Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  # Authentication
  get '/login', to: 'public/sessions#new'
  get '/logout', to: 'public/sessions#destroy'
  match '/auth/:provider/callback', to: 'public/sessions#create', as: :auth_login_callback, via: %i[get post]

  # Events
  get '/events/', to: 'public/events#index'
  get '/events/:id', to: 'public/events#show'

  # Dynamic page-matching
  match '/:page', to: 'public/pages#show',
                  via: :get,
                  constraints: ->(r) { Page.where(slug: r.params[:slug]).exists? }
  root to: 'public/pages#show'
end
