Given(/^I have a fresh OrangeHRM application$/) do
  `mysql orangehrm -uorangehrm -porangehrm < ../orangehrm/reset_database.sql`
end

Given(/^I open my OrangeHRM application$/) do
  visit 'http://orangehrm.app.dev.maestrano.io'
  maestrano_login
end
