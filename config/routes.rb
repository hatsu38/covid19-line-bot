Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # post '/callback' => 'linebot#callback'
  namespace :linebot do
    resources :client, only: :create
  end
end
