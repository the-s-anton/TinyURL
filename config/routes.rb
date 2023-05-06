Rails.application.routes.draw do
  resources :urls, only: %i[index create show]

  get '/:shortened', to: 'urls#redirect', as: :redirect

  root to: 'urls#index'
end
