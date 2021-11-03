When /I make a request to update article with article_ID (.*) with (.*)/ do |article_ID, new_content|
    #puts  ({ ":content": new_content.to_s}.to_json).to_s
    response1 = patch "/api/v1/articles/"+ article_ID,
                 params: {}.to_json,
                 "Content-Type" => "application/json"
    title = JSON.parse(response1.body)["article"]["title"]
    author_id = JSON.parse(response1.body)["article"]["author_id"]
    #@response = put "/api/v1/articles/"+article_ID.to_s,
    #     params: { ":content": new_content.to_s, "title": title, "author_id": author_id}.to_json,
    #     "Content-Type" => "application/json"
    #@response = patch(:update,:id=>:article_ID,article=>{:title=>title,:content=>new_content.to_s,:author_id=>author_id})
    puts @response.body:title, :content, :author_id
end

Then /^I should receive a response that involves (.*)/ do |new_content|
    expect(JSON.parse(@response.body)["article"]["content"]).to eq(new_content)
end


