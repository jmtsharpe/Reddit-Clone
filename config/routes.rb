Rails.application.routes.draw do

  resources :users, except: [:index]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index]
  resources :comments, only: [:create, :show]

end
