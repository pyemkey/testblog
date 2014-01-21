Easyblog::Application.routes.draw do
  root :to => "home#index"
  match "/index", to: 'home#index', via: [:get]
  devise_for :users
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
  end
end
