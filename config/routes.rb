Rails.application.routes.draw do

  resources :video_reports
  resources :video_entries
  resources :children
  resources :parents
  post '/login', to: 'auth#create'
  post '/parentLogin', to: 'auth#create_parent'
  post '/forgot_password', to: "passwords#forgot"
  post '/forgot_child_password', to: "passwords#forgot_child"
  post '/reset_password', to: "passwords#reset"
  get 'get_current_parent', to: "sessions#get_current_parent"

end
