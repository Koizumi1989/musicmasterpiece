Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "search" => "searches#search_result"

  resources :master_pieces, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
    resources :master_piece_comments, only:[:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
