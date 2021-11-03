require 'json'

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

When(/^I post a request to user login api with email "(.*)" and password "(.*)"$/) do |email, password|
  @response = post "/api/v1/authentication/login", { :email => email, :password => password }
end

Then(/^I should receive a response with status code "(.*)" with "(.*)" in the response body$/) do |status, message|
  expect(@response.status.to_s).to eq(status)
  expect(@response.body).to include(message)
end

When(/^I get the test api with valid token$/) do
  login_resp = post "/api/v1/authentication/login", { :email => "test1@columbia.edu", :password => "123123" }
  token = JSON.parse(login_resp.body)["token"]
  header "Authorization", token
  @response = get "/api/v1/authentication/test"
end

When(/^I get the test api with invalid token$/) do
  header "Authorization", "someinvalidtoken"
  @response = get "/api/v1/authentication/test"
end

# list steps

When /I send a get request to users api/ do
  @response = get "/api/v1/users",
                  params: {}.to_json,
                  "Content-Type" => "application/json"
end

Then /I should receive a response with (.*) users/ do | n_seeds |
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
end

# get steps

Then /I click certain user with ID of (.*)/ do | id |
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