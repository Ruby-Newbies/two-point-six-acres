json.usermail do
  json.(@usermail, :id, :from_user_id, :to_user_id, :content, :status, :created_at, :updated_at)
end