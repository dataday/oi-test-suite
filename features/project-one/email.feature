@v-0.1.0, @manual
Feature: Confirm email content
  As a subscriber
  I want to know if a subscription process has been successful
  And I want to know if a subscription process has been unsuccessful
  So that I can be confident that I will or will not receive a newsletter

  Background:
    Given a successful submission has been made
    When the submission has been processed
    Then I should receive the correct email notification

  Scenario: Receiving a confirmation email
    Given I check my email
    When I open the confirmation email
    Then I should see a confirmation link

  Scenario: Successful joined
    Given I receive a success confirmation email
    When I click the confirmation link
    Then I see a confirmation success page

  Scenario: Request expired
    Given I receive a expiry confirmation email
    When I click the confirmation link
    Then I see a confirmation expiry page

  Scenario: Successfully unsubscribe
    Given I receive a unsubscribe confirmation email
    When I click the confirmation link
    Then I see a confirmation unsubscribe page
