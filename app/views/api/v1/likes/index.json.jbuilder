json.array! @likes do |like|
  json.(like, :user_id, :article_id, :kind)
end
