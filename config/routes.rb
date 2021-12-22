Rails.application.routes.draw do
  # root "articles#index"

  devise_for :users

  resources :conversations do
    resources :posts
  end

  resources :contacts
end
