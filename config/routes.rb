require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  resources :urls, only: %i[index create show]

  get '/:shortened', to: 'urls#redirect', as: :redirect

  root to: 'urls#index'
end
