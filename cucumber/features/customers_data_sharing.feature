@organization @person
Feature: Data Sharing - Customers
  Contacts created in Dolibarr are pushed to SimpleInvoices and vTiger

  Background:
    Given I have a fresh Dolibarr application
    And I have a fresh SimpleInvoices application
    And I have a fresh vTiger application
  
  Scenario: Create a new customer in Dolibarr
    Given I open my Dolibarr application
    And I go to the Third Parties tab
    And I create a new third party
      | Name              | Type     | 
      | Test Organization | Customer |
    When I display the list of Customers
    And I select the Customer "Test Organization"
    And I add a Contact to this Customer
      | First name       | Last name     | 
      | John             | Smith         |

    Then Connec should contain the Organizations
      | Name              |
      | Test Organization |
    And Connec should contain the Contacts
      | First name   | Last name |
      | John         | Smith     |

    Given I open my SimpleInvoices application
    And I go to the Customers tab
    Then I should see the Customer "John Smith"

    Given I open my vTiger application
    And I go to the vTiger Organizations tab
    Then I should see the following Organizations in vTiger
      | Organization name |
      | Test Organization |
    When I go to the vTiger Contacts tab
    Then I should see the following Contacts in vTiger
      | First name | Last name | Organization name |
      | John       | Smith     | Test Organization |
