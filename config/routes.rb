Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/create-group',  to: 'groups#new'
  get    '/groups/:id/edit',  to: 'groups#edit'
  patch  'groups/:id', to: 'groups#update'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy] do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  resources :relationships,       only: [:create, :destroy]
  resources :groups
  resources :group_memberships, only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
end
