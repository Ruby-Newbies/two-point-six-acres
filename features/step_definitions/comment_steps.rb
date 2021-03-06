token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

Given /the following comments exist/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create comment
  end
end

Then /(.*) seed comments should exist/ do | n_seeds |
  expect(Comment.count).to eq(n_seeds.to_i)
end

# list steps

When /I send a get request to comments api/ do
  # user click comments list button
  @response = get "/api/v1/comments",
                  params: {}.to_json,
                  "Content-Type" => "application/json"
end

When /I send a get list request to comments api with article_ID (.*)/ do |article_ID|
  # user click comments list button
  # @response = get "/api/v1/comments",
  #                 params: {}.to_json,
  #                 "Content-Type" => "application/json"
  @response = get("/api/v1/comments", {article_id: article_ID})
end

Then /I should receive a response with (.*) comments/ do | n_seeds |
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
end

# get steps

Then /I click certain comment with ID of (.*)/ do | id |
  response = get "/api/v1/comments/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  expect(JSON.parse(response.body)["comment"]["id"]).to eq(id.to_i)
end

# delete steps

When /^I post a request to delete comment with comment_ID (.*)/ do |comment_ID|
  header "Authorization", token
  @response = delete "/api/v1/comments/"+comment_ID,to_s,
                     params: {}.to_json,
                     "Content-Type" => "application/json"
  #puts @response.body
end

Then /^I should receive a response showing the ID of the comment deleted: (.*)/ do |comment_ID|
  expect(JSON.parse(@response.body)["comment"]["id"]).to eq(comment_ID.to_i)
end

# post steps

When(/^I post a request to create a comment after article "(.*)" with content "(.*)", and author_id "(.*)"$/) do |article_id, content, author_id|
  header "Authorization", token
  @response = post "/api/v1/comments", { :article_id => article_id, :content => content, :author_id => author_id }
end

Then /^I should receive a response showing the new comment was posted with content: (.*)/ do |content|
  expect(@response.body).to include(content)
end