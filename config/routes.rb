Rails.application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root "dashboard#index"

  get "/dashboard", to: "dashboard#index", as: "dashboard"

  get "/calendar(/:year/:month)", to: "calendar#index", as: "calendar"

  get "/workout/list(/:year/:month)", to: "workout#list", as: "workout_list"
  get "/workout/details/:id", to: "workout#details", as: "workout_details"
end
