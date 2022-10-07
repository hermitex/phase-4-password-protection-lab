Rails.application.routes.draw do
  post '/signup' => 'users#create'
  get '/me' => 'users#show'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
