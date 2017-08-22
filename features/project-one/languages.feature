@v-0.1.0
Feature: Confirm language content
  As an editor
  I want to see content translated into different languages
  So when the language changes I know the content can be understood

  Background:
    Given I visit a newsletter page
    Then I see a subscription form

  Scenario Outline: Accessing supported languages
    Given I visit a <language> page
    When I see the submit button with <submit_text>
    Then I see the email field with <email_text>

    Examples: of supported languages
    | language | submit_text  | email_text              |
    | en       | Subscribe    | Your email address      |
    | cy       | Tanysgrifio  | Eich cyfeiriad e-bost   |
    | gd       | Clàraich     | Seòladh-d               |
    | ga       | Glac síntiús | Do sheoladh ríomhphoist |

  Scenario Outline: Accessing unsupported languages
    Given I visit a <language> page
    When I see the submit button with <submit_text>
    Then I see the email field with <email_text>

    Examples: of unsupported languages
    | language | submit_text | email_text         |
    | foo      | Subscribe   | Your email address |
    | zh       | Subscribe   | Your email address |
    | py       | Subscribe   | Your email address |
    | _        | Subscribe   | Your email address |
