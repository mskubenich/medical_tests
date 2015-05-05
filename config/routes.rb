Rails.application.routes.draw do

  resources :pages, only: [:index]

  resources :categories, except: [:show] do
    collection do
      post :upload_file
    end
    member do
      get :ask
      get :state
      get :next_question
      post :answer_question
      post :reset_game
    end
    resources :questions, except: [:show] do
      resources :answers, except: [:show] do

      end
    end
  end

  root 'pages#index'
end
