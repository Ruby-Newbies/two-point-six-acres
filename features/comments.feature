Feature: comments

  As a user of 2 point 3 acres
  I want to retrieve all comments or just retrieve a comment by its author_id

  Background: comments in database
  Given the following comments exist:
    | id  | article_id | author_id | content   |
    | 1   | 1          | 1         | Great     |
    | 2   | 1          | 2         | wwwww     |
    Then 2 seed comments should exist

  Scenario: get comment list and detail
    When I send a get request to comments api
    Then I should receive a response with 2 comments
    Then I click certain comment with ID of 1

#  Scenario: login with a non-exist account
#    When I post a request to user login api with username "abc" and password "abc"
#    Then I should receive a response saying "login failed"