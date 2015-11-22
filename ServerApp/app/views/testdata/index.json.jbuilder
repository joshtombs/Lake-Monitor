json.array!(@testdata) do |testdatum|
  json.extract! testdatum, :id, :field1, :field2
  json.url testdatum_url(testdatum, format: :json)
end
