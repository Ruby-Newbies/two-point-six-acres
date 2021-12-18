require 'json'

Given /the following likes exist/ do |likes_table|
  likes_table.hashes.each do |like|
    Like.create like
  end
end

When /I post a request to like an article with no params/ do
  @response = post "/api/v1/likes",
        params: {}.to_json,
        "Content-Type" => "application/json"
end

When /I post a request to like an article with user_id (.*), article_id (.*), kind (.*)/ do |user_id, article_id, kind|
  @response = post "/api/v1/likes",
                    { :user_id => user_id, :article_id => article_id, :kind => kind },
                    "Content-Type" => "application/json"
end

When /I send a get request to countLikes api with no params/ do
  @response = get "/api/v1/likes/count",
          params: {}.to_json,
          "Content-Type" => "application/json"
end

When /I send a get request to countLikes api with article_id (.*), kind (.*)/ do |article_id, kind|
  @response = get "/api/v1/likes/count",
                    { :article_id => article_id, :kind => kind },
                    "Content-Type" => "application/json"
end

When /I send a get request to liked api with no params/ do
  @response = get "/api/v1/likes/liked",
            params: {}.to_json,
            "Content-Type" => "application/json"
end
  
When /I send a get request to liked api with user_id (.*), article_id (.*)/ do |user_id, article_id|
  @response = get "/api/v1/likes/liked",
                    { :user_id => user_id, :article_id => article_id },
                    "Content-Type" => "application/json"
end

Then /I should receive a response with status code "(.*)" with "(.*)" in the response$/ do |status, message|
  expect(@response.status.to_s).to eq(status)
  expect(@response.body).to include(message)
end