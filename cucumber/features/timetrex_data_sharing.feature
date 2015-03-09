@timetrex
Feature: TimeTrex data sharing
  Data created in TimeTrex are pushed to Connec!

  Background:
    Given I have a fresh TimeTrex application
  
  Scenario: Create a new employee in TimeTrex
    Given I open my TimeTrex application
    And I go to the Employee List in TimeTrex
