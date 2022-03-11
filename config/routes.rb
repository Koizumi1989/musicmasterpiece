Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "search" => "searches#search_result"

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :master_pieces, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
    resources :master_piece_comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy, :index]
  end

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
