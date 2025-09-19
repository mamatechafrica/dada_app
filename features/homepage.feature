# features/homepage.feature

Feature: Homepage
  As a visitor to the Dada app
  I want to see an inspiring homepage
  So that I can learn about menopause support and decide to join the community

  Background:
    Given the app has featured stories available

  Scenario: Visitor views the homepage
    When I visit the homepage
    Then I should see the site title "Dada"
    And I should see the main heading "Your Menopause Journey, Your Way"
    And I should see featured stories
    And I should see navigation options to join or sign in

  Scenario: Visitor sees featured stories
    When I visit the homepage
    Then I should see 3 featured stories
    And each story should display the author's location and age
    And each story should have a verified badge

  Scenario: Visitor navigates to join community
    When I visit the homepage
    And I click "Join Community"
    Then I should be on the user registration page

  Scenario: Visitor navigates to sign in
    When I visit the homepage
    And I click "Sign In"
    Then I should be on the user sign in page