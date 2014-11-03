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
      | INV-001        | Created | $2,400.00    |

  Scenario: Push a new Invoice from Connec
    Given Connec contains the Organizations
      | I | Name            | Type                | Billing Address                          | Shipping Address                                    | Email                     | Website                    | Phone        |
      | 1 | ABC Furnitures  | Supplier            | 21 High Street;Sydney;2000;NSW;Australia | 411 Elisabeth Street;Surry Hills;2010;NSW;Australia | contact@abcfurnitures.com | http://abcfurnitures.com   | 02 4367 0091 |
      | 2 | Bay Side Bistro | Customer            | 22 High Street;Sydney;2000;NSW;Australia | 412 Elisabeth Street;Surry Hills;2010;NSW;Australia | contact@baysidebistro.com | http://baysidebistro.com   | 02 4367 0092 |
      | 3 | Office National | Customer & Supplier | 23 High Street;Sydney;2000;NSW;Australia | 413 Elisabeth Street;Surry Hills;2010;NSW;Australia | contact@office.nation.com | http://office.national.com | 02 4367 0093 |
    And Connec contains the Contacts
      | Id | First Name | Last Name | Organziation Id |
      | 1  | John       | Smith     | 1               |
      | 2  | Jack       | Bauer     | 1               |
      | 3  | Roger      | Johnson   | 2               |
      | 4  | Belinda    | Smith     | 2               |
      | 5  | Melissa    | Benson    | 3               |
      | 6  | Lee        | Wong      | 3               |
    And Connec contains the Accounts
      | Id | Name    | Code | Description             | Currency | Classification | Type | Sub Type |
      | 1  | Savings | 090  | Company savings account | AUD      | ASSET          | BANK | SAVINGS  |
