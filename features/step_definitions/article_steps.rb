Given /^the following articles exist:$/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create article
  end
end

Then /(.*) seed articles should exist/ do | n_seeds |
  # assert_equal Article.count, n_seeds.to_i
  expect(Article.count).to eq(n_seeds.to_i)
end

When /I send a get request to articles api/ do
  # user click comments list button

end

Then /I should receive a response with (.*) articles/ do | n_seeds |
  response = get "/api/v1/articles",
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  assert_equal JSON.parse(response.body).size, n_seeds.to_i
end

Then /I click certain article with ID of (.*)/ do | id |
  response = get "/api/v1/articles/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  assert_equal JSON.parse(response.body)["article"]["id"], id.to_i
end


# Then(/^I should receive a response saying "(.*)"$/) do |message|
#
# end