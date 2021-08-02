Rails.application.routes.draw do
  resources :filings, only: :index
  resources :receivers, only: :index
end
