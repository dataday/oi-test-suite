@v-0.1.0
Feature: Confirm submission content
  As an subscriber
  I want to confirm mandatory submission values are present
  So that I can be confident that only my email needs to be entered

  Background:
    Given I visit a newsletter page
    Then I see a subscription form

  @manual
  Scenario Outline: Submitting a email address (@js)
    Given I enter '<data>' as a <type>
    When <result> data '<data>' for <group> is submitted
    Then I see the <result> message

    Examples: of email submission, TODO use test account
    | type  | group          | data                                    | result  |
    | email | The Newsletter | <script>alert(document.cookie)</script> | error   |
    | email | The Newsletter | nobody@domain.co.uk                     | success |
    | email | The Newsletter | foo.bar.com                             | error   |
