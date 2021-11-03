Feature: get articles

  As a user of 2 point 6 acres
  1. I can retrieve all articles or just retrieve an article by its id.
  2. I can express my latest idea and correct mistakes so I want to update my article.
  3. I can also delete certain article.

  Background: articles in database
  Given the following articles exist
    | id  | title           | content                | author_id |
    | 1   | New Article     | This is my new article |   1       |
    | 2   | New Article     | This is my new article |   2       |
    Then 2 seed articles should exist

  Scenario: get article list and detail
    When I send a get request to articles api
    Then I should receive a response with 2 articles
    Then I click certain article with ID of 1

  Scenario: post a request to update article
    When I make a request to update article with article_ID 1 with NewContentHere
    Then I should receive a response that involves NewContentHere

  Scenario: post a request to delete article
    When I post a request to delete article with article_ID 2
    Then I should receive a response showing the ID of the article deleted: 2