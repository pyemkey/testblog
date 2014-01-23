Easyblog::Application.routes.draw do
  root :to => "home#index"
  match "/index", to: 'home#index', via: [:get]
  devise_for :users
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
    resource :comments do
    	post :mark_as_not_abusive, :vote_up
    end
  end
  
end
