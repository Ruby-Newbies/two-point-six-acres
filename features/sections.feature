Feature: functions regarding sections: create, get and delete sections

  As a user of 2 point 6 acres
  1. I can retrieve all sections or just retrieve a section by its id.
  3. I can also delete a certain section.
  4. I can also create a new section.

  Background: section in database
    Given the following sections exist
      | id  | title          |
      | 1   | test_section_1 |
      | 2   | test_section_2 |
    Then 2 seed sections should exist

  Scenario: list all sections
    When I make a request to list all sections
    Then I should receive a response with "2" sections

  Scenario: get a specific section
    When I make a request to get section with id "1"
    Then I should receive a response with section title "test_section_1"

  Scenario: post a request to create an section
    When I post a request to create a section with title "test_title"
    Then I should receive a response with status code "201"

  Scenario: post a request to delete an existing section
    When I post a request to delete section with id "1"
    Then I should receive a response with status code "200"

  Scenario: post a request to delete a non-existing section
    When I post a request to delete section with id "100"
    Then I should receive a response with status code "400"