When /^I go to the Third Parties tab$/ do
  page.find(:xpath, "/html/body/div[3]/div/ul/li[2]/div[2]/a[1]").click
end

When /^I create a new third party$/ do |table|
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[3]/a").click
  
  table.hashes.each do |row|
		fill_in 'nom', :with => row['Name']
    select(row['Type'], :from => 'client')
    select('Small company', :from => 'typent_id')
	end

  click_button 'Add third party'
end

When /^I display the list of Customers$/ do
  step %{I go to the Third Parties tab}
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[6]/a").click
end

When /^I select the Customer "(.*?)"$/ do |customer|
  customers_list = page.find('table.liste')
  customer_link = customers_list.all('a').select{ |a| a.text == customer }.first
  raise "Customer #{customer} not found in the list" unless customer_link

  customer_link.click
end

When /^I add a Contact to this Customer$/ do |table|
  page.find(:xpath, "/html/body/div[5]/div[2]/div/table[1]/tbody/tr/td[2]/a").click

  table.hashes.each do |row|
    fill_in 'lastname', :with => row['Last name']
    fill_in 'firstname', :with => row['First name']
    select('Mr.', :from => 'civilite_id')
  end

  click_button 'Add'
end
