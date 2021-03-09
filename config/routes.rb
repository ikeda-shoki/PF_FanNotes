Rails.application.routes.draw do

  root to: "post_images#top"
  post '/guest_sign_in', to: 'post_images#new_guest'

  devise_for :users

  get '/post_images/main', to: 'post_images#main', as: 'main'
  resources :post_images do
    resources :post_image_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get '/user/:id/following', to: 'users#following', as: 'following'
  get '/user/:id/followed', to: 'users#followed', as: 'followed'
  get '/user/withdrawal', to: 'users#withdrawal'
  resources :users, only: [:show, :edit, :update, :destroy] do
    get '/requesting', to: 'requests#requesting', as: 'requesting'
    get '/requested', to: 'requests#requested', as: 'requested'
    get '/requesting_show/:id', to: 'requests#requesting_show', as: 'requesting_show'
    get '/requested_show/:id', to: 'requests#requested_show', as: 'requested_show'
    patch '/update_request_status/:id', to: 'requests#update_request_status', as: 'update_request_status'
    patch '/update_request_complete_image/:id', to: 'requests#update_request_complete_image', as: 'update_request_complete_image'
    get '/request/:id/done', to: 'requests#request_done', as: 'request_done'
    get '/request/:id/complete', to: 'requests#request_complete', as: 'request_complete'
    resources :requests, only: [:new, :create, :edit, :update, :destroy]
  end

  post 'follow/:id', to: 'relationships#follow', as: 'follow'
  delete 'follow/:id', to: 'relationships#unfollow', as: 'unfollow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
