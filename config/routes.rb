Rails.application.routes.draw do

  resources :video_reports
  resources :audio_reports
  resources :video_entries
  resources :audio_entries
  resources :reports
  resources :journal_entries
  resources :children
  resources :parents
  post '/login', to: 'auth#create'
  post '/parentLogin', to: 'auth#create_parent'

end
