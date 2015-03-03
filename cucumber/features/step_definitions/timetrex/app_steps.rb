Given(/^I have a fresh TimeTrex application$/) do
  `mysql timetrex -utimetrex -ptimetrex < ../timetrex/reset_database.sql`
end

Given(/^I open my TimeTrex application$/) do
  visit 'http://timetrex.app.dev.maestrano.io'
  maestrano_login
end
