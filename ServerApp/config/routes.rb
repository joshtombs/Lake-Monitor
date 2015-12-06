Rails.application.routes.draw do
  resources :sensordata  

  get 'previous_data' => 'sensordata#previous'
  get 'previous_data/:month/:year' => 'sensordata#previous_month'
  get 'show_previous/:month/:year/:day' => 'sensordata#previous_day'

  get 'sensor_information' => 'sensors#index'
  get 'edit_sensor/:id' => 'sensors#edit'
  
  post 'edit_sensor/:id' => 'sensors#update'

  get 'contacts' => 'contactinfo#index'
  
  get 'contact_admin' => 'messages#new'
  post 'contact_admin' => 'messages#create'

  get 'admin_login' => 'sessions#new'
  post 'admin_login' => 'sessions#create'
  get 'admin_logout' => 'sessions#destroy'

  get 'sensor/:id' => 'sensors#get_update_rate'

  get "previous_posts" => "sensordata#previous_posts"
  post "update_posts" => "sensordata#update_posts"

  root :to => 'sensordata#index'
  match "*path", to: "sensordata#index", via: :all
end
