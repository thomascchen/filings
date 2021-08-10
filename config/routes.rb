Rails.application.routes.draw do
  resources :filings, only: [:index, :show]
  resources :receivers, only: :index
end
