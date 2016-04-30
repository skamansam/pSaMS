Feature: Manage Posts
  In order to create content
  As an admin user
  I want to be able to manage posts

  Scenario: Add a post
    Given I am an "admin" user
    And I have the credentials "email123@123.com/test123"
    And there is a category with name "testCat"
    When I sign in to the admin console
    And go to the new posts page
    And I fill in the fields:
      | title      | body                  | category |
      | new post 1 | this is a new post    | testCat |
      | new post 2 | this is a second post | testCat |
      | new post 3 | this is a third post  | testCat |
    And  I go to the category page for "testCat"
    Then I should see "new post 3" is .post .title 1
    And  I should see "new post 2" is .post .title 2
    And  I should see "new post 1" is .post .title 3

  Scenario: Delete a post

  Scenario: Edit a post

  Scenario: View all posts

  Scenario: View all posts in a category
