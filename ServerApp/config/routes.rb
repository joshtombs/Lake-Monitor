Rails.application.routes.draw do
  resources :sensordata  

  get 'previous_data' => 'sensordata#previous'
  get 'previous_data/:month/:year' => 'sensordata#previous_range'
  get 'show_previous/:id' => 'sensordata#show_previous'

  get 'contacts' => 'contactinfo#index'
  
  root :to => 'sensordata#index'
  match "*path", to: "sensordata#index", via: :all
end
