Feature: functions regarding likes: create, count likes, and check like status

  As a user of 2 point 6 acres
  1. I can like/dislike an article
  2. I can see how many people liked a specific article.
  3. I can see whether I liked/disliked a specific article.

  Background: likes in database
  Given the following likes exist
    | id  | user_id | article_id   | kind |
    | 1   | 1       | 1            | 1    |
    | 2   | 2       | 2            | 2    |

  Scenario: like an article with wrong params
    When I post a request to like an article with no params
    Then I should receive a response with status code "400" with "missing input" in the response
    
  Scenario: like an article with correct params
    When I post a request to like an article with user_id 1, article_id 2, kind 1
    Then I should receive a response with status code "200" with "1" in the response

  Scenario: like an article that is already liked
    When I post a request to like an article with user_id 1, article_id 1, kind 1
    Then I should receive a response with status code "400" with "already liked/disliked" in the response

  Scenario: see how many people liked a specific article
    When I send a get request to countLikes api with no params
    Then I should receive a response with status code "400" with "wrong condition" in the response
    When I send a get request to countLikes api with article_id 1, kind 1
    Then I should receive a response with status code "200" with "1" in the response
  
  Scenario: see whether I liked/disliked a specific article
    When I send a get request to liked api with no params
    Then I should receive a response with status code "400" with "wrong condition" in the response
    When I send a get request to liked api with user_id 2, article_id 2
    Then I should receive a response with status code "200" with "2" in the response
    When I send a get request to liked api with user_id 3, article_id 2
    Then I should receive a response with status code "200" with "0" in the response