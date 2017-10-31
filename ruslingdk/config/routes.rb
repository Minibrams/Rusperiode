Rails.application.routes.draw do
  # Authentication
  post '/auth/:provider/callback', to: 'public/sessions#create'

  # Dynamic page-matching
  match '/:page', to: 'public/pages#show', via: :get
  root to: 'public/pages#show'
end
