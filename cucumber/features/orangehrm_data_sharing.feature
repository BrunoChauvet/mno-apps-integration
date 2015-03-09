@orangehrm
Feature: OrangeHRM data ashring
  Data created in OrangeHRM are pushed to Connec!

  Background:
    Given I have a fresh OrangeHRM application

  Scenario: Set Company details in OrangeHRM
    Given I open my OrangeHRM application
    And I go to the Organization General Information in OrangeHRM
    And I update the Organization General Information in OrangeHRM
      | Name       | Tax ID | Registration Number | Phone        | Fax          | Email           | Address 1      | Address 2 | City   | State | Zip  | Country   | Notes                  |
      | Orange HRM | 125814 | 251454111           | 02 4512 7845 | 02 5621 1200 | info@orange.com | 1 Short Street | Suite 200 | Sydney | NSW   | 2000 | Australia | Created from OrangeHRM |
    Then Connec should contain the Company
      | Name       | Tax Number | Employer Number | Phone        | Fax          | Email           | Address 1      | Address 2 | City   | State | Zip  | Country | Notes                  |
      | Orange HRM | 125814     | 251454111       | 02 4512 7845 | 02 5621 1200 | info@orange.com | 1 Short Street | Suite 200 | Sydney | NSW   | 2000 | AU      | Created from OrangeHRM |

  Scenario: Create a new employee in OrangeHRM
    Given I open my OrangeHRM application
    And I go to the Employee List tab in OrangeHRM
    And I create a new employee in OrangeHRM
      | First name      | Last name          | Employee ID |
      | John            | Red                | EM034       |
    Then Connec should contain the Employees
      | First name      | Last name          | Employee ID |
      | John            | Red                | EM034       |

    When I edit the Employee "EM034" in OrangeHRM
    And I update the employee personal details in OrangeHRM to
      | First name      | Last name          | Employee ID | SSN Number   | Gender | Date of birth |
      | John            | Red                | EM034       | 123-1245-112 | Male   | 1972-01-20    |
    Then Connec should contain the Employees
      | First name      | Last name          | Employee ID | SSN Number   | Gender | Date of birth |
      | John            | Red                | EM034       | 123-1245-112 | M      | 1972-01-20    |

    And I update the employee contact details in OrangeHRM to
      | Address Street 1 | Address Street 2 | City        | State | Postal Code | Country   | Home Telephone | Mobile       | Work Telephone | Work Email       | Other Email         |
      | 410 Elisabeth St | Suite 102        | Surry Hills | NSW   | 2010        | Australia | 12 4578 4512   | 04 7889 5623 | 02 4569 3214   | info@company.com | contact@company.com |
    Then Connec should contain the Employees
      | Employee ID | Address Street 1 | Address Street 2 | City        | State | Postal Code | Country | Home Telephone | Mobile       | Work Telephone | Work Email       | Other Email         |
      | EM034       | 410 Elisabeth St | Suite 102        | Surry Hills | NSW   | 2010        | AU      | 12 4578 4512   | 04 7889 5623 | 02 4569 3214   | info@company.com | contact@company.com |

  Scenario: Add an Employee TimeSheet in OrangeHRM
    Given I open my OrangeHRM application
    And I go to the Employee List tab in OrangeHRM
    And I create a new employee in OrangeHRM
      | First name      | Last name          | Employee ID |
      | John            | Red                | EM034       |
    And I go to the Customer List tab in OrangeHRM
    And I create a new customer in OrangeHRM
      | Name            | Description        |
      | Doe Corp        | Doe Corp ltd.      |
    And I go to the Project List tab in OrangeHRM
    And I create a new Project in OrangeHRM
      | Customer | Name            | Description                |
      | Doe Corp | Build a house   | Build a house for Doe Corp |
    And I create a new Project Activity in OrangeHRM
      | Name          |
      | Build Phase 1 |
    And I view the TimeSheets for Employee "John Red" in OrangeHRM
    And I a TimeSheet for "2015-01-01" this Employee in OrangeHRM
    And I edit the current TimeSheet in OrangeHRM
