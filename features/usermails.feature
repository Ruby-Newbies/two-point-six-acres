Feature: functions regarding comments: add, get and delete comments

  As a user of 2 point 6 acres
  1. I can retrieve all comments or just retrieve a comment by its author_id.
  2. I can add a comment to certain article to make discussion.
  3. I can avoid outdated comment and mistakes to affect others by deleting my comment.

  Background: usermails are already in database
  Given the following usermails exist
    | id  | from_user_id | to_user_id | content              | status  |
    | 1   | 1            | 2          | message from 1 to 2  |  0      |
    | 2   | 2            | 1          | message from 2 to 1  |  0      |
    Then 2 seed usermails should exist

  Scenario: get usermail list and detail
    When I send a get request to usermails api
    Then I should receive a response with 2 usermails
    When I send a get list request to usermails api with to_user_id 1
    Then I should receive a response with 1 usermails

  Scenario: post a request to send a mail
    When I post a request to create a usermail from user "2" to user "3", with content "test_usermail_content"
    Then I should receive a response showing the new usermail was sent with content: "test_usermail_content"

  Scenario: read a usermail
    When I read a usermail with usermail_id 1
    Then I should receive a response with status 1