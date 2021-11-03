json.array! @users do |user|
  json.(user, :username, :email, :password_digest, :created_at, :updated_at)
end