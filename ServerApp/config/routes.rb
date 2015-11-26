Rails.application.routes.draw do
  resources :sensordata  

  get 'previous_data' => 'sensordata#previous'
  get 'previous_data/:month/:year' => 'sensordata#previous_month'
  get 'show_previous/:month/:year/:day' => 'sensordata#previous_day'

  get 'contacts' => 'contactinfo#index'
  get 'contact_admin' => 'contactinfo#contact_admin'

  root :to => 'sensordata#index'
  match "*path", to: "sensordata#index", via: :all
end
