When /^I go to the Financial tab$/ do
  page.find(:xpath, "/html/body/div[3]/div/ul/li[5]/div[2]/a[1]").click
end

When /^I create a new invoice in Dolibarr$/ do |table|
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[3]/a").click
  
  table.hashes.each do |row|
		select(row['Customer'], :from => 'socid')
    if row['Date']
      fill_in 're', :with => row['Date']
    else
      page.find('#reButtonNow').click
    end
    select('Credit card', :from => 'mode_reglement_id')
	end

  click_button 'Create draft'
end

When /^I change the Dolibarr invoice customer reference to "(.*?)"$/ do |invoice_number|
  page.find(:xpath, "/html/body/div[5]/div[2]/div/div[2]/table[1]/tbody/tr[2]/td[1]/table/tbody/tr/td[2]/a").click
  fill_in 'ref_client', :with => invoice_number
  click_button 'Modify'
end

When /^I change the Dolibarr invoice due date to "(.*?)"$/ do |due_date|
  page.find(:xpath, "/html/body/div[5]/div[2]/div/div[2]/table[1]/tbody/tr[8]/td[1]/table/tbody/tr/td[2]/a").click
  fill_in 'paymentterm', :with => due_date
  click_button 'Modify'
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
