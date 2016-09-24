Rails.application.routes.draw do
  devise_for :users
  root 'application#angular'

  resources :projects, only: [:create, :update, :destroy, :index] do
    resources :tasks, only: [:create, :update, :destroy, :show] do
      resources :comments, only: [:create, :update, :destroy]
    end
  end
end
