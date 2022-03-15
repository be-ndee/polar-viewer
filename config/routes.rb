Rails.application.routes.draw do
  root "calendar#index"

  get "/calendar", to: "calendar#index", as: "calendar"

  get "/workout/:year/:month", to: "workout#list", as: "workout_list"
  get "/workout/details/:id", to: "workout#details", as: "workout_details"
end
