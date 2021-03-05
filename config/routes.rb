Rails.application.routes.draw do

  root to: "post_images#top"
  post '/guest_sign_in', to: 'post_images#new_guest'

  devise_for :users

  resources :post_images do
    resources :post_image_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get '/user/:id/following', to: 'users#following', as: 'following'
  get '/user/:id/followed', to: 'users#followed', as: 'followed'
  get '/user/withdrawal', to: 'users#withdrawal'
  resources :users, only: [:show, :edit, :update, :destroy]

  post 'follow/:id', to: 'relationships#follow', as: 'follow'
  delete 'follow/:id', to: 'relationships#unfollow', as: 'unfollow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
