Feature: functions regarding follows: create, get, and delete follows

  As a user of 2 point 6 acres
  1. I can retrieve my followers and my following list.
  2. I can follow a user.
  3. I can also unfollow a user.

  Background: follows in database
  Given the following follows exist
    | id  | user_id | follower_id  |
    | 1   | 1       | 2            |
    | 2   | 2       | 1            |
    Then 2 seed follows should exist
  Scenario: get follow list and detail
    When I send a get request to follows api without user_id and follower_id
    Then I should receive a response with 2 follows
    When I send a get list request to follows api with user_id 2
    Then I should receive a response with 0 follows
    When I send a get list request to follows api with follower_id 1
    Then I should receive a response with 0 follows


  Scenario: post a request to create article
    When I post a request to create an follow relation with user_id 2, follower_id 1
    Then I should receive a response showing the new follow realtion was posted with user_id: 2

  Scenario: post a request to delete a follow relation
    When I send a isFollowed request with user_id 2, follower_id 1
    Then I should receive a response showing the relation exists
    When I send a isFollowed request with user_id 5, follower_id 4
    Then I should receive a response showing the relation non-exists

  Scenario: check whether a user is following another user
    When I post a request to delete a follow relation with user_id 2, follower_id 1
    Then I should receive a response showing the the follow relation deleted: user_id 2, follower_id 1