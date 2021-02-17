Rails.application.routes.draw do
  resources :home
  root 'home#index'
  get '/select' => "home#select"

  post 'workout/index' => "workout#index"
  get 'workout/index' => "workout#index"
  #get '/' => "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
