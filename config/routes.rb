Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
post '/login', to: "sessions#create"
post "/signup", to: "users#create"
delete "/logout", to: "sessions#destroy"
get '/me', to: "users#show"
end
