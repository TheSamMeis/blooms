json.array!(@users) do |user|
  json.extract! user, :F_name, :string, :L_name, :string, :email, :salt, :fish, :string
  json.url user_url(user, format: :json)
end
