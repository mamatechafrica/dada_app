# features/onboarding.feature

Feature: User Onboarding
  As a newly registered user
  I want to complete my profile setup
  So that I can receive personalized menopause guidance

  Background:
    Given I am a registered user
    And I am signed in
    And I have not completed onboarding

  Scenario: Complete onboarding successfully
    When I visit the dashboard
    Then I should be redirected to the onboarding page
    When I select my menopause stage as "Perimenopause"
    And I enter my location as "Lagos, Nigeria"
    And I select my preferred language as "English"
    And I enter my symptoms as "Hot flashes, Night sweats"
    And I enter my preferences as "Natural remedies, Community support"
    And I submit the onboarding form
    Then I should have completed onboarding
    And I should be redirected to the dashboard
    And I should see a personalized welcome message

  Scenario: Navigate between onboarding steps
    When I visit the onboarding page
    Then I should see the current step indicator
    And I should be able to navigate between steps
    And I should see progress through the onboarding flow

  Scenario: Anonymous name generation
    When I complete the onboarding form
    Then I should be assigned a culturally appropriate anonymous name
    And the name should be one of "Sister", "Mama", or "Auntie"
    And it should include a nature-inspired color

  Scenario: Onboarding validation
    When I visit the onboarding page
    And I try to submit without selecting a menopause stage
    Then I should see a validation error
    And I should remain on the onboarding page