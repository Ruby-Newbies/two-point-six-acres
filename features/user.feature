Feature: user login

  As a user of 2 point 6 acres
  I want to login with my own account by username and password
  As a new user
  I want to register with username, email, and password_digest

  Background: users in database
  Given the following users exist:
    | username | email | password_digest |
    | test1 | test1@columbia.edu | 123123 |
    | test2 | test2@columbia.edu | 456456 |

  Scenario: get user list and detail
    When I send a get request to users api
    Then I should receive a response with 2 users
    Then I click certain user with ID of 1

  Scenario: register to create a new user
    When I post a request to register with username "test3" , email "test3@columbia.edu", and password_digest "789789"
    Then I should receive a response showing the new user was created with username: "test3"
  
  Scenario: post a request to delete an existing user
    When I post a request to delete user with id "1"
    Then I should receive a response with status code "200"

  Scenario: post a request to delete a non-existing user
    When I post a request to delete user with id "50"
    Then I should receive a response with status code "400"

  Scenario: post a request to update a user
    When I post a request to update user with id "1" with new username "NewUsernameHere"
    Then I should receive response that involves NewUsernameHere

