Given(/^I have a fresh vTiger application$/) do
  `mysql vtiger -uvtiger -pvtiger < ../vtiger/reset_database.sql`
end

Given(/^I open my vTiger application$/) do
  visit 'http://vtiger.app.dev.maestrano.io'
  maestrano_login
end
