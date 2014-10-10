When /^I go to the Invoices tab$/ do
  page.find(:xpath, "/html/body/div[5]/ul/li[2]/a").click
  page.find(:xpath, "/html/body/div[5]/div[2]/ul/li[1]/a").click
end

When /^I select the invoice number "(.*?)"$/ do |invoice_number|
  page.find(:xpath, "/html/body/div[6]/div[1]/div[4]/table/tbody/tr[#{invoice_number}]/td[1]/div/a[1]").click
end

Then /^I should see the following Invoice details$/ do |table|
  table.hashes.each do |row|
    page.find(:xpath, "/html/body/div[6]/table[1]/tbody/tr[17]/td[2]").text.should eql(row['Customer'])
    page.find(:xpath, "/html/body/div[6]/table[1]/tbody/tr[32]/td[3]").text.should eql(row['Net Total'])
    page.find(:xpath, "/html/body/div[6]/table[1]/tbody/tr[33]/td[3]").text.should eql(row['Tax Total'])
    page.find(:xpath, "/html/body/div[6]/table[1]/tbody/tr[34]/td[3]/span").text.should eql(row['Gross Total'])

    
  end
end
