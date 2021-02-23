Rails.application.routes.draw do

  # resources :users do
  resources :users, only: [:new, :create, :show, :edit, :update] do
    collection do
      post :confirm
    end
  end

  # get 'sessions/new'
  resource :sessions, only: [:new, :create, :destroy]

  resources :feeds do
    collection do
      post :confirm
    end
  end

  resources :comments, only:[:new, :create, :destroy, :edit, :update]
  resources :favorites, only:[:new, :create, :destroy]

  get '/', to: 'feeds#index'  
  get '/users/:id/favorites', to: 'feeds#index', as: 'favorite_feeds'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
