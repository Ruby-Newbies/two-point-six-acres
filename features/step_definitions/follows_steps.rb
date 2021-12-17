token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

Given /the following follows exist/ do |follows_table|
  follows_table.hashes.each do |follow|
    Follow.create follow
  end
end

Then /(.*) seed follows should exist/ do | n_seeds |
  expect(Follow.count).to eq(n_seeds.to_i)
end

# # list steps
#
When /I send a get request to follows api without user_id and follower_id/ do
  @response = get "/api/v1/follows",
      params: {}.to_json,
      "Content-Type" => "application/json"
end

When /I send a get list request to follows api with user_id (.*)/ do |user_id|
  @response = get "/api/v1/follows",
                  {:user_id=>user_id},
                  "Content-Type" => "application/json"
  puts JSON.parse(@response.body)
end

When /I send a get list request to follows api with follower_id (.*)/ do |follower_id|
  @response = get("/api/v1/follows", {follower_id: follower_id})
end

Then /I should receive a response with (.*) follows/ do | n_seeds |
  expect(JSON.parse(@response.body)["total"]).to eq(n_seeds.to_i)
end

# create steps
When(/^I post a request to create an follow relation with user_id (.*), follower_id (.*)$/) do |user_id, follower_id|
  header "Authorization", token
  @response = post "/api/v1/follows", { :user_id => user_id.to_i, :follower_id => follower_id.to_i }
end

Then /^I should receive a response showing the new follow realtion was posted with user_id: (.*)/ do |user_id|

  expect(@response.body).to include(user_id)
end

# delete steps
When(/^I post a request to delete a follow relation with user_id (.*), follower_id (.*)$/) do |user_id, follower_id|
  header "Authorization", token
  @response = delete "/api/v1/follows/1", { :user_id => user_id.to_i, :follower_id => follower_id.to_i }
end

Then /^I should receive a response showing the the follow relation deleted: user_id (.*), follower_id (.*)/ do |user_id, follower_id|
  expect(JSON.parse(@response.body)["follow"]["user_id"]).to eq(user_id)
  expect(JSON.parse(@response.body)["follow"]["follower_id"]).to eq(follower_id)
end

# isFollowed steps
When(/^I send a isFollowed request with user_id (.*), follower_id (.*)$/) do |user_id, follower_id|
  header "Authorization", token
  @response = get "/api/v1/follows/isFollowed", { :user_id => user_id.to_i, :follower_id => follower_id.to_i }
end

Then /^I should receive a response showing the relation exists/ do
  puts JSON.parse(@response.body)
  expect(JSON.parse(@response.body)["res"]).to eq(true)
end

Then /^I should receive a response showing the relation non-exists/ do
  puts JSON.parse(@response.body)
  expect(JSON.parse(@response.body)["res"]).to eq(false)
end

