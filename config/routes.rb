Rails.application.routes.draw do

  resources :pages, only: [:index]

  resources :categories do
    collection do
      get :list
    end
    resources :subcategories do
      collection do
        get :list
      end
      resources :profiles do
        collection do
          get :list
        end
        resources :questions do
          collection do
            get :ask_random
            post :upload_file
          end
        end
      end
    end
  end

  root 'pages#index'
end
