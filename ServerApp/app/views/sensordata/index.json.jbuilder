json.array!(@sensordata) do |sensordata|
  json.extract! sensordata, :id, :time_recorded, :sensor_id, :value
  json.url sensordata_url(sensordata, format: :json)
end
