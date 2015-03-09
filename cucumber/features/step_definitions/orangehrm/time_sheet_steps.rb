Given(/^I view the TimeSheets for Employee "(.*?)" in OrangeHRM$/) do |employee_name|
  page.find('#menu_time_viewTimeModule').hover
  page.find('#menu_time_Timesheets').hover
  page.find('#menu_time_viewEmployeeTimesheet', visible: true).click

  fill_in 'employee', :with => employee_name
  page.all('div.ac_results ul li').first.click

  page.find('#btnView').click
end

Given(/^I a TimeSheet for "(.*?)" this Employee in OrangeHRM$/) do |time_sheet_date|
  page.find('#btnAddTimesheet').click
  fill_in 'time_date', :with => time_sheet_date
  page.find('#btnAddTimesheet').click
end

Given(/^I edit the current TimeSheet in OrangeHRM$/) do |table|
  page.find('#btnEdit').click

  table.hashes.each_with_index do |row, index|
    fill_in "initialRows_#{index}_projectName", :with => row['Project']
    page.all('div.ac_results ul li').first.click
  end

  page.find('#btnSave').click
end
