Rails.application.routes.draw do
  resources :filings, only: :index
end
