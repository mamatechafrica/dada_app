# features/user_registration.feature

Feature: User Registration
  As a woman seeking menopause support
  I want to register for the Dada community
  So that I can access personalized guidance and connect with other women

  Background:
    Given I am on the homepage

  Scenario: Successful user registration
    When I click "Join Community"
    And I fill in the registration form with valid details
    And I submit the registration form
    Then I should be registered and signed in
    And I should see a welcome message
    And I should be redirected to the onboarding flow

  Scenario: Registration with invalid email
    When I click "Join Community"
    And I fill in the registration form with an invalid email
    And I submit the registration form
    Then I should see an error message about the email format
    And I should remain on the registration page

  Scenario: Registration with mismatched passwords
    When I click "Join Community"
    And I fill in the registration form with mismatched passwords
    And I submit the registration form
    Then I should see an error message about password confirmation
    And I should remain on the registration page

  Scenario: Registration with existing email
    Given a user already exists with email "existing@example.com"
    When I click "Join Community"
    And I fill in the registration form with email "existing@example.com"
    And I submit the registration form
    Then I should see an error message about email already being taken
    And I should remain on the registration page