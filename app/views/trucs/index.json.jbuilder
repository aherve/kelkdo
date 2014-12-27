json.array!(@trucs) do |truc|
  json.extract! truc, :id, :name
  json.url truc_url(truc, format: :json)
end
