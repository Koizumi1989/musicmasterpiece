Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "search" => "searches#search_result"

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :master_pieces, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
    resources :master_piece_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
    collection do
      delete :post_destroy_all
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    get "likes" => "likes#index"
    get "search" => "users#search"
    collection do
      get :unsubscribe
      patch :withdraw
    end
  end

  resource :contacts, only: [:new, :create] do
    collection do
      get :complete
    end
  end

  resources :notifications, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
