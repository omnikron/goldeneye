json.array!(@weapon_sets) do |weapon_set|
  json.extract! weapon_set, :id
  json.url weapon_set_url(weapon_set, format: :json)
end
