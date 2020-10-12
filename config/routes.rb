Rails.application.routes.draw do
  root 'home#home'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      get :icon
    end
  end
  resources :posts do
    collection do
      post :confirm
    end
  end
    resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
