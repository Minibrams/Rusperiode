Rails.application.routes.draw do
  match '/:page', to: 'public/pages#show', via: :get
  root to: 'public/pages#show'
end
