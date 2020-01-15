Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :accounts, only: %i[show index create update]
  resources :users, only: %i[show index create update]
  post :generate_token, path: '/users/generate_token', action: :generate_token, controller: 'users'
end
