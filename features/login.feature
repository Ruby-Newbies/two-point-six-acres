Feature: user login

  As a user of 2 point 6 acres
  I want to login with my own account by username and password

  Background: users in database
  Given the following users exist:
    | username | email | password_digest |
    | test1 | test1@columbia.edu | 123123 |
    | test2 | test2@columbia.edu | 456456 |

  Scenario: login with an existing email and correct password
    When I post a request to user login api with email "test1@columbia.edu" and password "123123"
    Then I should receive a response with status code "200" with "token" in the response body

  Scenario: login with a non-existing email
    When I post a request to user login api with email "test3@columbia.edu" and password "abc"
    Then I should receive a response with status code "401" with "wrong email" in the response body

  Scenario: login with an existing email but wrong password
    When I post a request to user login api with email "test1@columbia.edu" and password "123456"
    Then I should receive a response with status code "401" with "unauthorized" in the response body

  Scenario: login with an empty email
    When I post a request to user login api with email "" and password "123456"
    Then I should receive a response with status code "401" with "missing input" in the response body