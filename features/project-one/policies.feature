@v-0.1.0
Feature: Confirm policy content
  As an editor
  I want to inform users of Company policy
  And confirm consent for minors
  So that we can offer an opt in email service to receive related Company content

  Background:
    Given I visit a newsletter page
    Then I see a subscription form

  Scenario: Accessing Company policy content
    Given policy content exists
    When I see the privacy link with Privacy & Cookies Policy
    Then the privacy link takes me to the privacy page

  Scenario Outline: Accessing Company related and consent content
    Given <content_type> content exists
    Then I see the <content_type> checkbox unchecked by default

    Examples: of content types
    | content_type |
    | related      |
    | consent      |
