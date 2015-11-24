json.array!(@sensordata) do |sensordata|
  json.extract! sensordata, :id, :time_recorded, :wind_speed, :wind_direction, :rainfall, :water_level, :water_temp, :ambient_temp, :humidity, :flow_rate
  json.url sensordata_url(sensordata, format: :json)
end
