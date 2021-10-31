json.article do
  json.(@article, :id, :title, :content, :author_id, :created_at, :updated_at)
end