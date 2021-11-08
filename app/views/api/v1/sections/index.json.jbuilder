json.array! @sections do |section|
  json.(section, :id, :title, :created_at, :updated_at)
end