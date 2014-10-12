When /^I go to the vTiger Organizations tab$/ do
  page.find(:xpath, "/html/body/table[2]/tbody/tr/td[2]/table/tbody/tr/td[6]/a").click
end

Then /^I should see the following Organizations in vTiger$/ do |table|
  eventually {
    actual_hash = [['Organization name']]
    organizations_table = page.find(:xpath, '/html/body/table[4]/tbody/tr/td[2]/div[4]/form/table/tbody/tr[1]/td/div/table')
    organizations_table.all('tr').drop(2).each do |table_row|
      organization_name = table_row.all('td')[2].first('a').text
      actual_hash << [organization_name]
    end

    begin
      table.diff! actual_hash
    rescue
      visit current_path
      raise "Organizations do not match, found: #{actual_hash}"
    end
  }
end

When /^I go to the vTiger Contacts tab$/ do
  page.find(:xpath, "/html/body/table[2]/tbody/tr/td[2]/table/tbody/tr/td[8]/a").click
end

Then /^I should see the following Contacts in vTiger$/ do |table|
  eventually {
    actual_hash = [['First name', 'Last name', 'Organization name']]
    contacts_table = page.find(:xpath, '/html/body/table[4]/tbody/tr/td[2]/div[4]/form/table/tbody/tr[1]/td/div/table')
    contacts_table.all('tr').drop(2).each do |table_row|
      first_name = table_row.all('td')[2].first('a').text
      last_name = table_row.all('td')[3].first('a').text
      organization_name = table_row.all('td')[5].first('a').text
      actual_hash << [first_name, last_name, organization_name]
    end

    begin
      table.diff! actual_hash
    rescue
      visit current_path
      raise "Contacts do not match, found: #{actual_hash}"
    end
  }
end
