Rails.application.routes.draw do

  resources :pages, only: [:index]

  resources :categories do
    collection do
      post :upload_file
    end
    resources :subcategories do
      resources :profiles do
        resources :questions
        member do
          get :ask
        end
      end
    end
  end

  root 'pages#index'
end
