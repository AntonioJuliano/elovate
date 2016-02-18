Rails.application.routes.draw do
  root :controller => 'homepage', :action => :index

  resources :users
end
