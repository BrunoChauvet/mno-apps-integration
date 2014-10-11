@organization @person @item @invoice
Feature: Data Sharing - Customers
  Data created in Dolibarr are pushed to SimpleInvoices

  Background:
    Given I have a fresh Dolibarr application
    And I have a fresh SimpleInvoices application
  
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

    Given I open my SimpleInvoices application
    And I go to the Customers tab
    Then I should see the Customer "John Smith"

    Given I open my Dolibarr application
    And I go to the Products and Service tab
    And I create a new product
      | Reference      | Name          | Price   |
      | PRO-001        | Stone Table   | 1200    |
    When I display the list of Products
    And I select the Product "PRO-001"

    Given I open my SimpleInvoices application
    And I go to the Products tab
    Then I should see the Product "Stone Table"

    Given I open my Dolibarr application
    And I go to the Financial tab
    And I create a new invoice
      | Customer          |
      | Test Organization |
    And I add a new line to the invoice
      | Product     | Quantity |
      | Stone Table | 2        |

    Given I open my SimpleInvoices application
    And I go to the Invoices tab
    And I select the invoice number "1"
    Then I should see the following Invoice details
      | Customer   | Net Total | Tax Total | Gross Total |
      | John Smith | $2,181.82 | $218.18   | $2,400.00   |
