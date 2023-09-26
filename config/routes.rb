Rails.application.routes.draw do
  get "api/v0/forecast", to: "api/v0/forecasts#show"
  post "api/v0/users", to: "api/v0/users#create"
  post "api/v0/sessions", to: "api/v0/sessions#create"
end
