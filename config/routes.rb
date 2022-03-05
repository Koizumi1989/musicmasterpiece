Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  resources :master_pieces, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
    collection do
      get :search
    end
    resources :master_piece_comments, only:[:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
  collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
