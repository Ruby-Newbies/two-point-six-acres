token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

Given /the following usermails exist/ do |usermails_table|
  usermails_table.hashes.each do |usermail|
    Usermail.create usermail
  end
end

Then /(.*) seed usermails should exist/ do | n_seeds |
  expect(Usermail.count).to eq(n_seeds.to_i)
end

When /I send a get request to usermails api/ do
  header "Authorization", token
  @response = get "/api/v1/usermails",
                  params: {}.to_json,
                  "Content-Type" => "application/json"
end

Then /I should receive a response with (.*) usermails/ do | n_seeds |
  # expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
  expect(JSON.parse(@response.body)["total"]).to eq(n_seeds.to_i)
end

When /I send a get list request to usermails api with to_user_id (.*)/ do |to_user_id|
  header "Authorization", token
  @response = get("/api/v1/usermails", {to_user_id: to_user_id})
end

When(/^I post a request to create a usermail from user "(.*)" to user "(.*)", with content "(.*)"$/) do |from_user_id, to_user_id, content|
  header "Authorization", token
  @response = post "/api/v1/usermails", { :from_user_id => from_user_id, :to_user_id => to_user_id, :content => content }
end

Then /^I should receive a response showing the new usermail was sent with content: (.*)/ do |content|
  expect(@response.body).to include(content)
end

When /I make a request to update usermail with usermail_id (.*) with (.*)/ do |article_ID, new_content|
  header "Authorization", token
  response1 = get "/api/v1/articles/"+ article_ID.to_s,
                  params: {}.to_json,
                  "Content-Type" => "application/json"
  title = JSON.parse(response1.body)["article"]["title"]
  author_id = JSON.parse(response1.body)["article"]["author_id"]
  section_id = JSON.parse(response1.body)["article"]["section_id"]
  @response = patch "/api/v1/articles/"+article_ID.to_s, { :content => new_content.to_s, :title=>title, :author_id => author_id, :id => article_ID.to_s, :section_id => section_id}
end

When /I read a usermail with usermail_id (.*)/ do |usermail_id|
  header "Authorization", token
  response1 = get "/api/v1/usermails/"+ usermail_id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  # puts response1
  from_user_id = JSON.parse(response1.body)["usermail"]["from_user_id"]
  to_user_id = JSON.parse(response1.body)["usermail"]["to_user_id"]
  content = JSON.parse(response1.body)["usermail"]["content"]
  @response = patch "/api/v1/usermails/"+usermail_id.to_s, { :status => 1, :from_user_id => from_user_id, :to_user_id => to_user_id, :content=> content}
end

Then /^I should receive a response with status (.*)/ do |status|
  expect(JSON.parse(@response.body)["usermail"]["status"]).to eq(status.to_i)
end

# list steps
