json.article do
  json.(@article, :id, :title, :content, :section_id, :updated_at)
end