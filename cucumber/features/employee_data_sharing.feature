@employee
Feature: Data Sharing - Employees
  Employees created in OrangeHRM and TimeTrex are pushed to Connec!

  Background:
    Given I have a fresh OrangeHRM application
    And I have a fresh TimeTrex application
  
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
      | John            | Red                | EM034       | 123-1245-112 | Males  | 1972-01-20    |
    Then Connec should contain the Employees
      | First name      | Last name          | Employee ID | SSN Number   | Gender | Date of birth |
      | John            | Red                | EM034       | 123-1245-112 | Males  | 1972-01-20    |

    And I update the employee contact details in OrangeHRM to
      | Address Street 1 | Address Street 2 | City        | State | Postal Code | Country   | Home Telephone | Mobile       | Work Telephone | Work Email       | Other Email         |
      | 410 Elisabeth St | Suite 102        | Surry Hills | NSW   | 2010        | Australia | 12 4578 4512   | 04 7889 5623 | 02 4569 3214   | info@company.com | contact@company.com |
    Then Connec should contain the Employees
      | Employee ID | Address Street 1 | Address Street 2 | City        | State | Postal Code | Country   | Home Telephone | Mobile       | Work Telephone | Work Email       | Other Email         |
      | EM034       | 410 Elisabeth St | Suite 102        | Surry Hills | NSW   | 2010        | Australia | 12 4578 4512   | 04 7889 5623 | 02 4569 3214   | info@company.com | contact@company.com |

  Scenario: Create a new employee in TimeTrex
    Given I open my TimeTrex application
    And I go to the Employee List in TimeTrex
    