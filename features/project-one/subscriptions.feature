@v-0.1.0
Feature: Confirm subscription content
  As an editor
  I want to inform users of their subscription status
  And show whether the subscription has been successful or not

  Scenario Outline: Accessing a status page
    Given I visit a <status> page
    When the <status> text is shown
    Then the <status> should appear instead of a form

    Examples: of supported statuses
    | status      |
    | success     |
    | expired     |
    | complete    |
    | error       |
    | unsubscribe |

  Scenario Outline: Using the subscribe link
    Given I visit a <status> page
    When I see the subscribe link
    And I click the subscribe link
    Then I see a subscription form

    Examples: of supported statuses
    | status      |
    | success     |
    | expired     |
    | error       |
    | unsubscribe |
