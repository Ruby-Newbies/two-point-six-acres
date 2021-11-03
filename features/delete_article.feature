Feature: delete an existing article
    As a user
  So that I can avoid outdated content and mistakes to affect others
  I want to delete my article

Background: article already exists
    Given the following articles exist:
  | id            | content                    | author_id |
  | 1             | "This is my new article"   | 1         |
  | 2             | "This is my new article"   | 2         |

Scenario: post a request to delete article  
  When I post a request to delete article with article_ID 2
  Then I should receive a response showing the ID of the article deleted: 2