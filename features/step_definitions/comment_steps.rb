Given /^the following comments exist:$/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create comment
  end
end

Then /(.*) seed comments should exist/ do | n_seeds |
  assert_equal Comment.count, n_seeds.to_i
end

When /I send a get request to comments api/ do
  # user click comments list button
end

Then /I should receive a response with (.*) comments/ do | n_seeds |
  response = get "/api/v1/comments",
       params: {}.to_json,
       "Content-Type" => "application/json"
  assert_equal JSON.parse(response.body).size, n_seeds.to_i
end

Then /I click certain comment with ID of (.*)/ do | id |
  response = get "/api/v1/comments/"+ id.to_s,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
  assert_equal JSON.parse(response.body)["comment"]["id"], id.to_i
end

# Then(/^I should receive a response saying "(.*)"$/) do |message|
#
# end