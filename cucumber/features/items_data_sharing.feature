@item
Feature: Data Sharing - Items
  Items created in Dolibarr are pushed to SimpleInvoices

  Background:
    Given I have a fresh Dolibarr application
    And I have a fresh SimpleInvoices application
    And I have a fresh vTiger application
  
  Scenario: Create a new item in Dolibarr
    Given I open my Dolibarr application
    And I go to the Products and Service tab
    And I create a new product
      | Reference      | Name          | Price   |
      | PRO-001        | Stone Table   | 1200    |
    When I display the list of Products
    And I select the Product "PRO-001"
    # TODO: Check item page

    Then Connec should contain the Items
      | Code     | Name        | Unit price |
      | PRO-001  | Stone Table | 1200       |

    Given I open my SimpleInvoices application
    And I go to the Products tab
    Then I should see the Product "Stone Table"

    Given I open my vTiger application
    And I go to the vTiger Products tab
    Then I should see the following Products in vTiger
      | Product name | Product price |
      | Stone Table  | $1,090.91     |
