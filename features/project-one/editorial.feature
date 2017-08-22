@v-0.1.0
Feature: Confirm editorial content (Content is ordered correctly in the DOM)
  As an editor
  I want to see relevant editorial content
  So that the form reflects required content

  Background:
    Given I visit a newsletter page
    Then I see a subscription form

  Scenario: A title exists
    Given title content exists
    Then the title should appear 1st

  Scenario: A description exists
    Given description content exists
    Then the description should appear 2nd

  Scenario: A introductory exists
    Given introduction content exists
    Then the introduction should appear before the email field

  Scenario: A frequency exists
    Given frequency content exists
    Then the frequency should appear before the submit button
