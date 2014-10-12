Given(/^I have a fresh Dolibarr application$/) do
  `mysql dolibarr -udolibarr -pdolibarr < ../dolibarr/reset_database.sql`
end

Given(/^I open my Dolibarr application$/) do
  visit 'http://dolibarr.app.dev.maestrano.io'
  maestrano_login
end
