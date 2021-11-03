Feature: user login

  As a user of 2 point 3 acres
  I want to login with my own account by username and password

  Background: users in database
  Given the following users exist:
  # TODO: change the following data
    | username | email | password_digest |
    | test1 | test1@columbia.edu | 123123 |
    | test2 | test2@columbia.edu | 456456 |

  Scenario: login with an existing account
    When I post a request to user login api with email "test1@columbia.edu" and password "123123"
    Then I should receive a response saying "login success"

  Scenario: login with a non-exist account
    # TODO: change the username and password
    When I post a request to user login api with email "test3@columbia.edu" and password "abc"
    Then I should receive a response saying "login failed"