Feature: get articles

  As a user of 2 point 6 acres
  I want to retrieve all articles or just retrieve an article by its id

  Background: articles in database
  Given the following articles exist:
    | id  | title           | content                | author_id |
    | 1   | New Article     | This is my new article |   1       |
    | 2   | New Article     | This is my new article |   2       |
    Then 2 seed articles should exist

  Scenario: get article list and detail
    When I send a get request to articles api
    Then I should receive a response with 2 articles
    Then I click certain article with ID of 1

#  Scenario: login with a non-exist account
#    When I post a request to user login api with username "abc" and password "abc"
#    Then I should receive a response saying "login failed"