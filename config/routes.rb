Rails.application.routes.draw do
  root "dashboard#index"

  get "/dashboard", to: "dashboard#index", as: "dashboard"

  get "/calendar", to: "calendar#index", as: "calendar"

  get "/workout/list/:year/:month", to: "workout#list", as: "workout_list"
  get "/workout/details/:id", to: "workout#details", as: "workout_details"
end
