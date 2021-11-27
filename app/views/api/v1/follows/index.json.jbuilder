json.array! @follows do |follow|
  json.(follow, :user_id, :follower_id)
end
