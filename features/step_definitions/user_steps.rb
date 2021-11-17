require 'json'
token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

# list steps

When /I send a get request to users api/ do
  header "Authorization", token
  @response = get "/api/v1/users",
                  params: {}.to_json,
                  "Content-Type" => "application/json"
end

Then /I should receive a response with (.*) users/ do | n_seeds |
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
end

# get steps

Then /I click certain user with ID of (.*)/ do | id |
  header "Authorization", token
  response = get "/api/v1/users/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  expect(JSON.parse(response.body)["user"]["id"]).to eq(id.to_i)
end

When(/^I post a request to register with username "(.*)" , email "(.*)", and password_digest "(.*)"$/) do |username, email, password_digest|
  # @response = post "/api/v1/users", :user => { :username => username, :email => email, :password_digest => password_digest}
  @response = post "/api/v1/users", :username => username, :email => email, :password_digest => password_digest
end


Then /^I should receive a response showing the new user was created with username: (.*)/ do |username|
  expect(@response.body).to include(username)
end

When /^I post a request to delete user with id "(.*)"$/ do |user_ID|
  header "Authorization", token
  @response = delete "/api/v1/users/"+user_ID.to_s,
                     params: {}.to_json,
                     "Content-Type" => "application/json"
end

Then /^I should receive a response showing the user ID of the user deleted: (.*)/ do |user_ID|
  expect(JSON.parse(@response.body)["user"]["id"]).to eq(user_ID.to_i)
end

When /I post a request to update user with id "(.*)" with new username "(.*)"$/ do |user_ID, username|
  #response1 = get "/api/v1/users/"+ user_ID,
  #             params: {}.to_json,
  #             "Content-Type" => "application/json"
  #email = JSON.parse(response1.body)["user"]["email"]
  header "Authorization", token
  @response = patch "/api/v1/users/"+user_ID, :id => user_ID, :username => username
end

Then /^I should receive response that involves (.*)/ do |new_username|
  expect(JSON.parse(@response.body)["user"]["username"]).to eq(new_username)
end