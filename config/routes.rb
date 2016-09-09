Rails.application.routes.draw do
	resources :users, only: [:index, :create, :show, :update, :destroy]

  resources :entries, only: [:index, :create, :show, :update, :destroy]

  resources :leagues, only: [:index, :create, :show, :update, :destroy] 
  resources :games, only: [:index, :create, :show, :update, :destroy]
end
