Rails.application.routes.draw do

  resources :video_reports
  resources :video_entries
  resources :children
  resources :parents
  post '/login', to: 'auth#create'
  post '/parentLogin', to: 'auth#create_parent'

end
