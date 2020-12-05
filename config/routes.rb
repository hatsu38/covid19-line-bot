Rails.application.routes.draw do
  root "health_check#index"
  namespace :linebot do
    resources :callback, only: :create
  end
  get "*anything" => "application#rescue_not_found"
end
