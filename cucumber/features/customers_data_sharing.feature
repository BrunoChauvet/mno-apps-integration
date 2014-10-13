@organization @person @item @invoice
Feature: Data Sharing - Customers
  Data created in Dolibarr are pushed to SimpleInvoices

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

    Then Connec should contain the Organization
      | Name              |
      | Test Organization |
    And Connec should contain the Contact
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

    Given I open my vTiger application
    And I go to the vTiger Products tab
    Then I should see the following Products in vTiger
      | Product name | Product price |
      | Stone Table  | $1,090.91     |

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
