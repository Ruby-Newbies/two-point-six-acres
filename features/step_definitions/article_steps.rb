Given /^the following articles exist:$/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create article
  end
end

Then /(.*) seed articles should exist/ do | n_seeds |
  expect(Article.count).to eq(n_seeds.to_i)
end

When /I send a get request to articles api/ do
  @response = get "/api/v1/articles",
      params: {}.to_json,
      "Content-Type" => "application/json"
end

Then /I should receive a response with (.*) articles/ do | n_seeds |
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
end

Then /I click certain article with ID of (.*)/ do | id |
  response = get "/api/v1/articles/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  expect(JSON.parse(response.body)["article"]["id"]).to eq(id.to_i)
end


# Then(/^I should receive a response saying "(.*)"$/) do |message|
#
# end