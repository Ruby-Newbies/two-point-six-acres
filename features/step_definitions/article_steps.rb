token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create article
  end
end

Then /(.*) seed articles should exist/ do | n_seeds |
  expect(Article.count).to eq(n_seeds.to_i)
end

# list steps

When /I send a get request to articles api/ do
  @response = get "/api/v1/articles",
      params: {}.to_json,
      "Content-Type" => "application/json"
end

When /I send a get list request to articles api with author_ID (.*)/ do |author_id|
  @response = get("/api/v1/articles", {author_id: author_id})
end

When /I send a get list request to articles api with section_ID (.*)/ do |section_id|
  @response = get("/api/v1/articles", {section_id: section_id})
end

Then /I should receive a response with (.*) articles/ do | n_seeds |
  expect(JSON.parse(@response.body)["total"]).to eq(n_seeds.to_i)
end



# get steps

Then /I click certain article with ID of (.*)/ do | id |
  response = get "/api/v1/articles/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  expect(JSON.parse(response.body)["article"]["id"]).to eq(id.to_i)
end


# delete steps

When /^I post a request to delete article with article_ID (.*)/ do |article_ID|
  header "Authorization", token
  @response = delete "/api/v1/articles/"+article_ID.to_s,
                     params: {}.to_json,
                     "Content-Type" => "application/json"
  #puts JSON.parse(@response.body)["article"]["id"]
end

Then /^I should receive a response showing the ID of the article deleted: (.*)/ do |article_ID|
  expect(JSON.parse(@response.body)["article"]["id"]).to eq(article_ID.to_i)
end


When(/^I post a request to create an article with title "(.*)", content "(.*)", author_id "(.*)", and section_id "(.*)"$/) do |title, content, author_id, section_id|
  header "Authorization", token
  @response = post "/api/v1/articles", { :title => title, :content => content, :author_id => author_id, :section_id => section_id }
end

Then /^I should receive a response showing the new article was posted with title: (.*)/ do |title|
  # expect(JSON.parse(@response.body)["article"]["title"]).to eq(title)
  expect(@response.body).to include(title)
end

When /I make a request to update article with article_ID (.*) with (.*)/ do |article_ID, new_content|
  header "Authorization", token
  response1 = get "/api/v1/articles/"+ article_ID.to_s,
               params: {}.to_json,
               "Content-Type" => "application/json"
  title = JSON.parse(response1.body)["article"]["title"]
  author_id = JSON.parse(response1.body)["article"]["author_id"]
  section_id = JSON.parse(response1.body)["article"]["section_id"]
  @response = patch "/api/v1/articles/"+article_ID.to_s, { :content => new_content.to_s, :title=>title, :author_id => author_id, :id => article_ID.to_s, :section_id => section_id}
end

Then /^I should receive a response that involves (.*)/ do |new_content|
  expect(JSON.parse(@response.body)["article"]["content"]).to eq(new_content)
end