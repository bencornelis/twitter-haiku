Rails.application.routes.draw do
  root "haiku_searches#new"
  resources :haiku_searches
  resources :user_searches
end
