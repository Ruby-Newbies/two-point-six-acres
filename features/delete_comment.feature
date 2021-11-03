Feature: delete an existing comment
    As a user
  So that I can avoid outdated comment and mistakes to affect others
  I want to delete my comment

Background: comment already exists
    Given the following comments exist:
  | id            | content      | author_id |
  | 1             | "Great"      | 1         |
  | 2             | "wwwwwwww"   | 2         |
  | 3             | "hahahah"    | 1         |
  
Scenario: post a request to delete article  
  When I post a request to delete comment with comment_ID 2
  Then I should receive a response showing the ID of the comment deleted: 2