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