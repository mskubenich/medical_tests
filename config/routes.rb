Rails.application.routes.draw do

  resources :pages, only: [:index]

  resources :categories do
    resources :subcategories do
      resources :profiles do
        resources :questions do
          collection do
            post :upload_file
          end
        end
      end
    end
  end

  root 'pages#index'
end
