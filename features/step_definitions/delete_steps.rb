Given /the following comments exist/ do |comments_table|
    comments_table.hashes.each do |comment|
        Comment.create comment
    end
end


When /^I post a request to delete comment with comment_ID (.*)/ do |comment_ID|
    @response = delete "/api/v1/comments/"+comment_ID,to_s,
         params: {}.to_json,
         "Content-Type" => "application/json"
    #puts @response.body
end

Then /^I should receive a response showing the ID of the comment deleted: (.*)/ do |comment_ID|
    expect(JSON.parse(@response.body)["comment"]["id"]).to eq(comment_ID.to_i)
end



When /^I post a request to delete article with article_ID (.*)/ do |article_ID|
    @response = delete "/api/v1/articles/"+article_ID.to_s,
         params: {}.to_json,
         "Content-Type" => "application/json"
    #puts JSON.parse(@response.body)["article"]["id"]
end

Then /^I should receive a response showing the ID of the article deleted: (.*)/ do |article_ID|
    expect(JSON.parse(@response.body)["article"]["id"]).to eq(article_ID.to_i)
end