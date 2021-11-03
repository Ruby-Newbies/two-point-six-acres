Feature: comments

  As a user of 2 point 3 acres
  1. I can retrieve all comments or just retrieve a comment by its author_id.
  2. I can avoid outdated comment and mistakes to affect others.
  3. I want to delete my comment.

  Background: comments in database
  Given the following comments exist
    | id  | article_id | author_id | content   |
    | 1   | 1          | 1         | Great     |
    | 2   | 1          | 2         | wwwww     |
    Then 2 seed comments should exist

  Scenario: get comment list and detail
    When I send a get request to comments api
    Then I should receive a response with 2 comments
    Then I click certain comment with ID of 1

  Scenario: post a request to delete comment
    When I post a request to delete comment with comment_ID 2
    Then I should receive a response showing the ID of the comment deleted: 2