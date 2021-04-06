Rails.application.routes.draw do

  root to: "post_images#top"
  post '/guest_sign_in', to: 'users#new_guest'

  devise_for :users

  get '/post_images/hashtag/:name', to: "post_images#hashtag", as: 'hashtag'
  get '/post_images/main', to: 'post_images#main', as: 'main'
  resources :post_images do
    resources :post_image_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get '/search', to: 'search#search'
  get '/post_image_search', to: 'search#post_image_search'
  get '/post_image_genre_search/:genre', to: 'search#post_image_genre_search', as: 'post_image_genre_search'
  get '/user_search', to: 'search#user_search'

  get '/user/:id/following', to: 'users#following', as: 'following'
  get '/user/:id/followed', to: 'users#followed', as: 'followed'
  get '/user/withdrawal', to: 'users#withdrawal'
  resources :users, only: [:show, :edit, :update, :destroy, :index] do
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

  get '/request/:request_id/chat/:id', to: 'chats#show', as: 'request_chat'
  resources :chats, only: [:create, :destroy]

  delete '/notifications/all_destroy', to: 'notifications#all_destroy'
  resources :notifications, only: [:index, :destroy]

  post 'follow/:id', to: 'relationships#follow', as: 'follow'
  delete 'follow/:id', to: 'relationships#unfollow', as: 'unfollow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
