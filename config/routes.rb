Rails.application.routes.draw do

  resources :pages, only: [:index]
  resources :categories

  root 'pages#index'
end
