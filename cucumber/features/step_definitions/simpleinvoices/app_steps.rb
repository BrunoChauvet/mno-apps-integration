Given(/^I have a fresh SimpleInvoices application$/) do
  `mysql simpleinvoices -usimpleinvoices -psimpleinvoices < ../simpleinvoices/reset_database.sql`
end

Given(/^I open my SimpleInvoices application$/) do
  visit 'http://simpleinvoices.app.dev.maestrano.io'
  maestrano_login
end