Rails.application.routes.draw do

  resources :pages, only: [:index]

  resources :categories do
    resources :subcategories do
      resources :profiles do
        resources :questions
      end
    end
  end

  root 'pages#index'
end
