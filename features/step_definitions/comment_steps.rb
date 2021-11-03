Given /^the following comments exist:$/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create comment
  end
end

Then /(.*) seed comments should exist/ do | n_seeds |
  expect(Comment.count).to eq(n_seeds.to_i)
end

When /I send a get request to comments api/ do
  # user click comments list button
  @response = get "/api/v1/comments",
                  params: {}.to_json,
                  "Content-Type" => "application/json"
end

Then /I should receive a response with (.*) comments/ do | n_seeds |
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
end

Then /I click certain comment with ID of (.*)/ do | id |
  response = get "/api/v1/comments/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  expect(JSON.parse(response.body)["comment"]["id"]).to eq(id.to_i)
end

# Then(/^I should receive a response saying "(.*)"$/) do |message|
#
# end