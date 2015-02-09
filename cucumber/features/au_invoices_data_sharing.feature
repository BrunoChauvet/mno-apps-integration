@invoice
Feature: Data Sharing - Invoices Australian configuration

  Background:
    Given I have a fresh Dolibarr application
    And I have a fresh SimpleInvoices application
    And I have a fresh vTiger application

  Scenario: Push a new Invoice from Connec
    Given Connec contains the Company
      | Name       | Currency | Shipping Address                         | Email                  | Website              |
      | My Company | AUD      | 21 High Street;Sydney;2000;NSW;Australia | info@mycompany.com     | http://mycompany.com |
    And Connec contains the Organizations
      | Id | Name            | Type                | Billing Address                          | Shipping Address                                    | Email                     | Website                    | Phone        |
      | 1  | ABC Furnitures  | Supplier            | 21 High Street;Sydney;2000;NSW;Australia | 411 Elisabeth Street;Surry Hills;2010;NSW;Australia | contact@abcfurnitures.com | http://abcfurnitures.com   | 02 4367 0091 |
      | 2  | Bay Side Bistro | Customer            | 22 High Street;Sydney;2000;NSW;Australia | 412 Elisabeth Street;Surry Hills;2010;NSW;Australia | contact@baysidebistro.com | http://baysidebistro.com   | 02 4367 0092 |
      | 3  | Office National | Customer & Supplier | 23 High Street;Sydney;2000;NSW;Australia | 413 Elisabeth Street;Surry Hills;2010;NSW;Australia | contact@office.nation.com | http://office.national.com | 02 4367 0093 |
    And Connec contains the Contacts
      | Id | First name | Last name | Organziation Id |
      | 1  | John       | Smith     | 1               |
      | 2  | Jack       | Bauer     | 1               |
      | 3  | Roger      | Johnson   | 2               |
      | 4  | Belinda    | Smith     | 2               |
      | 5  | Melissa    | Benson    | 3               |
      | 6  | Lee        | Wong      | 3               |
    And Connec contains the Accounts
      | Id | Name    | Code | Description             | Currency | Classification | Type   | Sub Type             |
      | 1  | Savings | 090  | Company savings account | AUD      | ASSET          | BANK   | SAVINGS              |
      | 2  | Sales   | 200  | Income from sales       | AUD      | REVENUE        | INCOME | SALESOFPRODUCTINCOME |
    And Connec contains the Tax Codes
      | Id | Name  | Description    | Sale Tax Rate |
      | 1  | GST   | Australian GST | 10            |
    And Connec contains the Items
      | Id | Code    | Name       | Description         | Type    | Sale Total Price | Sale Net Price | Sale Tax Rate | Sale Tax Code Id |
      | 1  | FUR-001 | Blue Pens  | Box of 12 blue pens | Product | 5.5              | 5              | 10            | 1                |
      | 2  | FUR-002 | Red Pens   | Box of 12 red pens  | Product | 5.5              | 5              | 10            | 1                |
    And Connec contains the Invoices
     | Id | Title      | Transaction Number | Transaction Date | Due Date   | Status | Type     | Total Amount | Balance | Deposit | Customer Id |
     | 1  | Pens order | INV-032311         | 2014-10-01       | 2014-10-15 | DRAFT  | Customer | 66           | 66      | 0       | 1           |
    And Connec Invoice "1" contains the Invoice Lines
     | Id | Line Number | Quantity | Reduction Percent | Unit Price | Unit Net Price | Total Price | Total Net Price | Item Id | Tax Code Id |
     | 1  | 1           | 6        | 0                 | 5.5        | 5              | 33          | 30              | 1       | 1           |
     | 2  | 2           | 6        | 0                 | 5.5        | 5              | 33          | 30              | 2       | 1           |

    # Given I open my SimpleInvoices application
    # And I go to the Invoices tab
    # And I select the invoice number "1"
    # Then I should see the following Invoice details
    #   | Customer   | Net Total | Tax Total | Gross Total |
    #   | John Smith | $60.00    | $6.00     | $66.00      |

    # Given I open my vTiger application
    # And I go to the vTiger Invoices tab
    # Then I should see the following Invoices in vTiger
    #   | Title          | Status  | Total amount |
    #   | Pens order     | Created | $66.00       |
