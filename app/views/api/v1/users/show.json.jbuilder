json.user do
  json.(@user, :id, :username, :email, :created_at, :updated_at)
end