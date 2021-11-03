Given /^the following users exist$/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

When(/^I post a request to user login api with email "(.*)" and password "(.*)"$/) do |username, password|
  # TODO: post a request to login the user
  response = post "/api/v1/authentication/login",
       params: {}.to_json,
       "Content-Type" => "application/json"
  puts response.body
end

Then(/^I should receive a response saying "(.*)"$/) do |message|
  # TODO: check the response
end