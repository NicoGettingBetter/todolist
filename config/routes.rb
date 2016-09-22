Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#angular'

  resources :projects, only: [:create, :update, :destroy, :index] do
    resources :tasks, only: [:create, :update, :destroy, :show] do
      resources :comments, only: [:create, :update, :destroy]
    end
  end
end
