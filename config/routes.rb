Rails.application.routes.draw do
  resources :favorites
  resources :users
  resources :sessions
  get '/', to: 'users#new'
    resources :users, only: [:new, :create, :show]
    resources :sessions, only: [:new, :create, :destroy]
    resources :favorites, only: [:create, :destroy]
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    resources :posts do
      collection do
        post :confirm

      end
    end
  end
