Rails.application.routes.draw do
  resources :sensordata  

  get 'previous_data' => 'sensordata#previous'
  get 'previous_data/:month/:year' => 'sensordata#previous_month'
  get 'show_previous/:month/:year/:day' => 'sensordata#previous_day'

  get 'sensor_information' => 'sensors#index'
  get 'edit_sensor/:id' => 'sensors#edit'
  
  put 'edit_sensor/:id' => 'sensors#update'

  get 'add_sensor' => 'sensors#add_sensor'
  post 'add_sensor' => 'sensors#create'

  get 'contacts' => 'contactinfo#index'
  get 'contact_admin' => 'contactinfo#contact_admin'

  get 'admin_login' => 'sessions#new'
  post 'admin_login' => 'sessions#create'
  get 'admin_logout' => 'sessions#destroy'

  root :to => 'sensordata#index'
  match "*path", to: "sensordata#index", via: :all
end
