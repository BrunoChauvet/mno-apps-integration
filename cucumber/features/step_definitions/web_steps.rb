Given(/^I am logged in on Maestrano$/) do
  visit 'http://application.maestrano.io/auth/users/sign_in'
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