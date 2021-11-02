json.user do
  json.(@user, :username, :email, :password_digest, :created_at, :updated_at)
end