Feature: user login

  As a user of 2 point 3 acres
  I want to login with my own account by username and password

  Background: users in database
  Given the following users exist:
  # TODO: change the following data
    | title        | rating | director     | release_date |
    | Star Wars    | PG     | George Lucas |   1977-05-25 |
    | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
    | Alien        | R      |              |   1979-05-25 |
    | THX-1138     | R      | George Lucas |   1971-03-11 |

  Scenario: login with an existing account
    # TODO: change the username and password
    When I post a request to user login api with username "abc" and password "abc"
    Then I should receive a response saying "login success"

  Scenario: login with a non-exist account
    # TODO: change the username and password
    When I post a request to user login api with username "abc" and password "abc"
    Then I should receive a response saying "login failed"