Rails.application.routes.draw do
  resources :master_pieces, only: [:index, :show, :create, :edit, :update, :destroy] do
  collection do
      get :search
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
  collection do
      get :search
    end
  end

  devise_for :users
  root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
