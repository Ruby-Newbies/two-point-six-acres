json.array! @comments do |comment|
  json.(comment, :id, :author_id, :article_id, :content, :created_at, :updated_at)
end