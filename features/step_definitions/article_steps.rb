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

Then /I should receive a response with (.*) articles/ do | n_seeds |
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
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
  @response = delete "/api/v1/articles/"+article_ID.to_s,
                     params: {}.to_json,
                     "Content-Type" => "application/json"
  #puts JSON.parse(@response.body)["article"]["id"]
end

Then /^I should receive a response showing the ID of the article deleted: (.*)/ do |article_ID|
  expect(JSON.parse(@response.body)["article"]["id"]).to eq(article_ID.to_i)
end

# Then(/^I should receive a response saying "(.*)"$/) do |message|
#
# end
When(/^I post a request to create an article with title "(.*)", content "(.*)", and author_id "(.*)"$/) do |title, content, author_id|
  @response = post "/api/v1/articles", :article => { :title => title, :content => content, :author_id => author_id }
end

Then /^I should receive a response showing the new article was posted with title: (.*)/ do |title|
  # expect(JSON.parse(@response.body)["article"]["title"]).to eq(title)
  expect(@response.body).to include(title)
end

When /I make a request to update article with article_ID (.*) with (.*)/ do |article_ID, new_content|
    
  response1 = get "/api/v1/articles/"+ article_ID.to_s,
               params: {}.to_json,
               "Content-Type" => "application/json"
  title = JSON.parse(response1.body)["article"]["title"]
  author_id = JSON.parse(response1.body)["article"]["author_id"]
  @response = patch "/api/v1/articles/"+article_ID.to_s, { :content => new_content.to_s, :title=>title, :author_id => author_id, :id => article_ID.to_s}
  puts @response.body
end

Then /^I should receive a response that involves (.*)/ do |new_content|
  expect(JSON.parse(@response.body)["article"]["content"]).to eq(new_content)
end