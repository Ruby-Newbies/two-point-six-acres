json.user do
  json.(@user, :username, :email, :created_at, :updated_at)
end