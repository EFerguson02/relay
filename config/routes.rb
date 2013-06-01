Relay::Application.routes.draw do

  resources :teams


  root to: 'Access#log_in', as: 'log_in'
  get "/access/remote_login", to: 'Access#remote_login'
  get "/access/log_out", to: 'Access#log_out', as: 'log_out'

  resources :users

  get "/home", to: 'Home#index' , as: 'homepage'

  get '/goal_page', to: 'Home#goal_page' , as: 'goal_page'

end
