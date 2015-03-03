Given(/^I go to the Employee List in TimeTrex$/) do
  eventually { page.find('#ribbon_view_container').click }
  click_link('Employee')
  page.find('#Employee').click
end

Given(/^I create a new employee in TimeTrex$/) do |table|
  click_link('New')

  # TODO... TimeTrex UI is really crap
end
