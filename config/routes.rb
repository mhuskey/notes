Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
    resources :notes
  end
  
  resources :password_resets, only: [:new, :create, :edit, :update]
  
end
