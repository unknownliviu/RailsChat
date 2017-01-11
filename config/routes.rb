Rails.application.routes.draw do
  devise_for :users
  resources :chat_rooms, only: [:new, :create, :index]
  root 'chat_rooms#index'

  get 'chat_rooms/:random_hash', to: 'chat_rooms#show', as: :private_chat

  mount ActionCable.server => '/cable'
end
