Given(/^I am logged in on Maestrano$/) do
  visit 'http://application.maestrano.io/auth/users/sign_in'

  page.first("#user_email").native.send_keys 'bruno.chauvet@maestrano.com'
  page.first("#user_password").native.send_keys 'password'
  click_button 'Log in'
end

Given(/^I have a fresh Dolibarr application$/) do
  `mysql dolibarr -udolibarr -pdolibarr < /home/bruno/Workspace/mno-apps-integration/dolibarr/reset_database.sql`
end

Given(/^I have a fresh SimpleInvoices application$/) do
  `mysql simpleinvoices -usimpleinvoices -psimpleinvoices < /home/bruno/Workspace/mno-apps-integration/simpleinvoices/reset_database.sql`
end

Given(/^I open my Dolibarr application$/) do
  visit 'http://dolibarr.app.dev.maestrano.io'
  maestrano_login
end

Given(/^I open my SimpleInvoices application$/) do
  visit 'http://simpleinvoices.app.dev.maestrano.io'
  maestrano_login
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

def maestrano_login
  if page.has_selector?('#user_email')
    page.first("#user_email").native.send_keys 'bruno.chauvet@maestrano.com'
    page.first("#user_password").native.send_keys 'password'
    click_button 'Log in'
  end
end