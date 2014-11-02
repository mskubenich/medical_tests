Rails.application.routes.draw do

  devise_for :users
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
          post :send_result
        end
      end
    end
  end

  root 'pages#index'
end
