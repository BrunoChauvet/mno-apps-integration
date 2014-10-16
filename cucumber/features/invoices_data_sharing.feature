@invoice
Feature: Data Sharing - Invoices
  Data created in Dolibarr are pushed to SimpleInvoices

  Background:
    Given I have a fresh Dolibarr application
    And I have a fresh SimpleInvoices application
    And I have a fresh vTiger application
  
  Scenario: Create a new invoice in Dolibarr
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

    And I go to the Products and Service tab
    And I create a new product
      | Reference      | Name          | Price   |
      | PRO-001        | Stone Table   | 1200    |

    And I go to the Financial tab
    And I create a new invoice in Dolibarr
      | Customer          | Date       |
      | Test Organization | 10/15/2014 |
    And I change the Dolibarr invoice customer reference to "INV-001"
    And I change the Dolibarr invoice due date to "10/25/2014"
    And I add a new line to the invoice
      | Product     | Quantity |
      | Stone Table | 2        |

    Then Connec should contain the Invoices
      | Number        | Date       | Due        | Status | Total amount |
      | INV-001       | 2014-10-15 | 2014-10-25 | DRAFT  | 2400.0       |

    Given I open my SimpleInvoices application
    And I go to the Invoices tab
    And I select the invoice number "1"
    Then I should see the following Invoice details
      | Customer   | Net Total | Tax Total | Gross Total |
      | John Smith | $2,181.82 | $218.18   | $2,400.00   |

    Given I open my vTiger application
    And I go to the vTiger Invoices tab
    Then I should see the following Invoices in vTiger
      | Invoice number | Status  | Total amount |
      | INV-001        | Created | 2,400.00     |
