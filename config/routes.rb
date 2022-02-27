Rails.application.routes.draw do
  root "calendar#index"

  get "/calendar", to: "calendar#index", as: "calendar"

  get "/workout", to: "workout#list_dates", as: "workout_dates"
  get "/workout/date/:date", to: "workout#list", as: "workout_list"
  get "/workout/details/:id", to: "workout#details", as: "workout_details"
end
