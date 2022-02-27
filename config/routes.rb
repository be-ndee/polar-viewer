Rails.application.routes.draw do
  root "calendar#index"

  get "/calendar", to: "calendar#index", as: "calendar"

  get "/training", to: "training#list_dates", as: "training_dates"
  get "/training/date/:date", to: "training#list", as: "training_list"
  get "/training/details/:id", to: "training#details", as: "training_details"
end
