@v-0.1.0
Feature: Confirm example content
  As an editor
  I want to inform users of the example content
  And confirm it's is present
  So that we can offer more content to be seen

  Background:
    Given I visit a example page
    Then I see example content

  Scenario: Accessing example content
    Given example content exists
    When I see the example content
    Then the example content shows something
