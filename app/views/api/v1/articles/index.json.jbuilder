json.array! @articles do |article|
  json.(article, :id, :title, :content, :author_id, :section_id, :created_at, :updated_at)
end