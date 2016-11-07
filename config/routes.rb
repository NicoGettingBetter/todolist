Rails.application.routes.draw do
  devise_scope :user do
    post 'auth/facebook' => 'auth#facebook'
    post 'auth/login' => 'auth#login'
    post 'auth/signup' => 'auth#signup'
  end
  mount_devise_token_auth_for 'User', at: 'auth'

  root 'application#angular'

  resources :projects, only: [:create, :update, :destroy, :index] do
    resources :tasks, only: [:create, :update, :destroy, :show] do
      resources :comments, only: [:create, :update, :destroy] do
        resources :file_attachments, only: [:create, :destroy]
      end
    end
  end
end
