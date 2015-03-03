Given(/^I go to the Employee List tab in OrangeHRM$/) do
  page.find('#menu_pim_viewPimModule').click
  page.find('#menu_pim_viewEmployeeList').click
end

Given(/^I create a new employee in OrangeHRM$/) do |table|
  page.find('#btnAdd').click

  table.hashes.each do |row|
    fill_in 'firstName', :with => row['First name']
    fill_in 'lastName', :with => row['Last name']
    fill_in 'employeeId', :with => row['Employee ID']
  end

  page.find('#btnSave').click
end

When(/^I edit the Employee "(.*?)" in OrangeHRM$/) do |employee_id|
  page.find('#menu_pim_viewPimModule').click
  page.find('#menu_pim_viewEmployeeList').click
  click_link employee_id
end

When(/^I update the employee personal details in OrangeHRM to$/) do |table|
  click_link 'Personal Details'
  page.find('#btnSave').click

  table.hashes.each do |row|
    fill_in 'personal_txtEmpFirstName', :with => row['First name']
    fill_in 'personal_txtEmpLastName', :with => row['Last name']
    fill_in 'personal_txtEmployeeId', :with => row['Employee ID']
    fill_in 'personal_txtNICNo', :with => row['SSN Number']
    page.find('#personal_optGender_1').click if row['Gender'] == 'Male'
    page.find('#personal_optGender_2').click if row['Gender'] == 'Female'
    fill_in 'personal_DOB', :with => row['Date of birth']
  end

  page.find('#btnSave').click
end

Then(/^I update the employee contact details in OrangeHRM to$/) do |table|
  click_link 'Contact Details'
  page.find('#btnSave').click

  table.hashes.each do |row|
    fill_in 'contact_street1', :with => row['Address Street 1']
    fill_in 'contact_street2', :with => row['Address Street 2']
    fill_in 'contact_city', :with => row['City']
    fill_in 'contact_province', :with => row['State']
    fill_in 'contact_emp_zipcode', :with => row['Postal Code']
    select(row['Country'], :from => 'contact_country')

    fill_in 'contact_emp_hm_telephone', :with => row['Home Telephone']
    fill_in 'contact_emp_mobile', :with => row['Mobile']
    fill_in 'contact_emp_work_telephone', :with => row['Work Telephone']
    fill_in 'contact_emp_work_email', :with => row['Work Email']
    fill_in 'contact_emp_oth_email', :with => row['Other Email']
  end

  page.find('#btnSave').click
end