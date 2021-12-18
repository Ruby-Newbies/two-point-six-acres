Feature: user login

  As a user of 2 point 6 acres
  I want to login with my own account by username and password
  I want to successfully access protected rest API if I have logged in
  If I am an administrator, I can login to administrator account and manage

  Background: users in database
  Given the following users exist:
    | username | email | password_digest  | role  |
    | test1 | test1@columbia.edu | 123123 | admin |
    | test2 | test2@columbia.edu | 456456 | user  |

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

  Scenario: visit test api with valid token
    When I get the test api with valid token
    Then I should receive a response with status code "200" with "success" in the response body

  Scenario: visit test api with invalid token
    When I get the test api with invalid token
    Then I should receive a response with status code "401" with "error" in the response body
  
  Scenario: admin login with a valid admin email and correct password
    When I post a request to admin login api with email "test2@columbia.edu" and password "456456"
    Then I should receive a response with status code "401" with "not admin" in the response body
  
  Scenario: admin login with a non-admin email and correct password
    When I post a request to admin login api with email "test1@columbia.edu" and password "123123"
    Then I should receive a response with status code "200" with "token" in the response body

  Scenario: admin login with a non-existing email
    When I post a request to admin login api with email "test3@columbia.edu" and password "abc"
    Then I should receive a response with status code "401" with "wrong email" in the response body

  Scenario: admin login with an existing email but wrong password
    When I post a request to admin login api with email "test1@columbia.edu" and password "123456"
    Then I should receive a response with status code "401" with "unauthorized" in the response body

  Scenario: admin login with an empty email
    When I post a request to admin login api with email "" and password "123456"
    Then I should receive a response with status code "401" with "missing input" in the response body