json.article do
  json.(@article, :id, :title, :content, :author_id, :section_id, :created_at, :updated_at)
end