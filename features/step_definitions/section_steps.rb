token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

Given /the following sections exist/ do |sections_table|
  sections_table.hashes.each do |section|
    Section.create section
  end
end

Then /^(.*) seed sections should exist$/ do |n_seeds|
  expect(Section.count).to eq(n_seeds.to_i)
end

When /^I make a request to list all sections$/ do
  header "Authorization", token
  @response = get "/api/v1/sections"
end

Then /^I should receive a response with "(.*)" sections$/ do |n_seeds|
  expect(JSON.parse(@response.body).size).to eq(n_seeds.to_i)
end

When /^I make a request to get section with id "(.*)"$/ do |section_id|
  header "Authorization", token
  @response = get "/api/v1/sections/" + section_id
end

Then /^I should receive a response with section title "(.*)"$/ do |section_title|
  expect(@response.body).to include(section_title)
end

When /^I post a request to create a section with title "(.*)"$/ do |section_title|
  header "Authorization", token
  @response = post "/api/v1/sections", :section => { :title => section_title}
end

Then /^I should receive a response with status code "(.*)"$/ do |status_code|
  expect(@response.status.to_s).to eq(status_code)
end

When /^I post a request to delete section with id "(.*)"$/ do |section_id|
  header "Authorization", token
  @response = delete "/api/v1/sections/" + section_id
end