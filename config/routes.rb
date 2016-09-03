Rails.application.routes.draw do
  root 'home#index'
  resources :things do
    member do
      post :create_comment
      get :next_comments
    end
  end
end
