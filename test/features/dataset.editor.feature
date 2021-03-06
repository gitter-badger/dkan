@javascript @api
Feature: Dataset Features
  In order to realize a named business value
  As an explicit system actor
  I want to gain some beneficial outcome which furthers the goal

  Additional text...


Background:
  Given pages:
    | title     | url       |
    | Datasets  | /dataset  |
  Given users:
    | name    | mail                | roles                |
    | John    | john@example.com    | site manager         |
    | Badmin  | admin@example.com   | site manager         |
    | Gabriel | gabriel@example.com | content creator      |
    | Jaz     | jaz@example.com     | editor               |
    | Katie   | katie@example.com   | content creator      |
    | Martin  | martin@example.com  | editor               |
    | Celeste | celeste@example.com | editor               |
  Given groups:
    | title    | author  | published |
    | Group 01 | Badmin  | Yes       |
    | Group 02 | Badmin  | Yes       |
    | Group 03 | Badmin  | No        |
  And group memberships:
    | user    | group    | role on group        | membership status |
    | Gabriel | Group 01 | administrator member | Active            |
    | Katie   | Group 01 | member               | Active            |
    | Jaz     | Group 01 | member               | Pending           |
    | Admin   | Group 02 | administrator member | Active            |
    | Celeste | Group 02 | member               | Active            |
  And "Tags" terms:
    | name    |
    | Health  |
    | Gov     |
  And datasets:
    | title      | publisher | author  | published        | tags     | description |
    | Dataset 01 | Group 01  | Gabriel | Yes              | Health   | Test        |
    | Dataset 02 | Group 01  | Gabriel | Yes              | Gov      | Test        |
    | Dataset 03 | Group 01  | Katie   | Yes              | Health   | Test        |
    | Dataset 04 | Group 02  | Celeste | No               | Gov      | Test        |
    | Dataset 05 | Group 01  | Katie   | No               | Gov      | Test        |
  And resources:
    | title       | publisher | format | author | published | dataset    | description |
    | Resource 01 | Group 01  | csv    | Katie  | Yes       | Dataset 01 |             |
    | Resource 02 | Group 01  | html   | Katie  | Yes       | Dataset 01 |             |
    | Resource 03 | Group 01  | html   | Katie  | Yes       | Dataset 02 |             |

  Scenario: Edit any dataset associated with the groups that I am a member of
    Given I am logged in as "Gabriel"
    And I am on "Dataset 03" page
    When I click "Edit"
    And I fill in "title" with "Dataset 03 edited"
    And I press "Finish"
    Then I should see "Dataset Dataset 03 edited has been updated"

  Scenario: Publish any dataset associated with the groups I am a member of
    Given I am logged in as "Gabriel"
    And I am on "Dataset 05" page
    When I click "Edit"
    When I click "Publishing options"
    And I check the box "Published"
    And I press "Finish"
    Then I should see "Dataset Dataset 05 has been updated"

  Scenario: I should not be able to edit datasets of groups that I am not a member of
    Given I am logged in as "Gabriel"
    When I am on "Dataset 04" page
    Then I should not see the link "Edit"

  Scenario: Delete any dataset associated with the groups that I am a member of
    Given I am logged in as "Gabriel"
    And I am on "Dataset 03" page
    When I click "Edit"
    When I press "Delete"
    And I press "Delete"
    Then I should see "Dataset Dataset 03 has been deleted"
