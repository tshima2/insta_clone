Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :edit, :update] do
#  resources :users do
    collection do
      post :confirm
    end
  end
  
  resource :sessions, only: [:new, :create, :destroy]
end
