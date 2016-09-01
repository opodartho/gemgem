Rails.application.routes.draw do
  root 'home#index'
  resources :things do
    resources :comments
  end
end
