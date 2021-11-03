Feature: update an existing article
    As a user
  So that I can express my latest idea and correct mistakes
  I want to update my article

Background: article already exists
    Given the following articles exist:
  | id            | content                    | author_id |
  | 1             | "This is my new article"   | 1         |
  | 2             | "This is my new article"   | 2         |

Scenario: post a request to update article
  When I make a request to update article with article_ID 1 with NewContentHere
  Then I should receive a response that involves NewContentHere