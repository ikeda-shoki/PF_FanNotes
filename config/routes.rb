Rails.application.routes.draw do
  
  root to: "post_images#top"
  post '/guest_sign_in', to: 'post_images#new_guest'
  
  devise_for :users
  
  resources :post_images do
    resources :post_image_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
