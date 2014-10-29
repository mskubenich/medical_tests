Rails.application.routes.draw do

  resources :pages, only: [:index]
  resources :categories do
    resources :subcategories
  end

  root 'pages#index'
end
