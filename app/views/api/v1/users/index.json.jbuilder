json.array! @users do |user|
  json.(user, :id, :username, :email, :role, :password_digest, :created_at, :updated_at)
end