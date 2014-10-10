When /^I go to the Financial tab$/ do
  page.find(:xpath, "/html/body/div[3]/div/ul/li[5]/div[2]/a[1]").click
end

When /^I create a new invoice$/ do |table|
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[3]/a").click
  
  table.hashes.each do |row|
		select(row['Customer'], :from => 'socid')
    page.find('#reButtonNow').click
    select('Credit card', :from => 'mode_reglement_id')
	end

  click_button 'Create draft'
end

When /^I add a new line to the invoice$/ do |table|
  table.hashes.each do |row|
    select(row['Product'], :from => 'idprod')
    page.find(:xpath, '/html/body/div[5]/div[2]/div/div[2]/table[2]/tbody/tr[5]/td[2]/input').native.clear
    page.find(:xpath, '/html/body/div[5]/div[2]/div/div[2]/table[2]/tbody/tr[5]/td[2]/input').native.send_keys row['Quantity']
  end

  page.find(:xpath, '/html/body/div[5]/div[2]/div/div[2]/table[2]/tbody/tr[5]/td[4]/input').click
end

When /^I display the list of Invoices$/ do
  step %{I go to the Financial tab}
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[1]/a").click
end
