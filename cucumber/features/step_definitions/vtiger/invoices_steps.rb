When /^I go to the vTiger Invoices tab$/ do
  # page.find(:xpath, "/html/body/table[2]/tbody/tr/td[2]/table/tbody/tr/td[12]/a").click
  visit 'http://vtiger.app.dev.maestrano.io/index.php?module=Invoice&action=index'
end

Then /^I should see the following Invoices in vTiger$/ do |table|
  eventually {
    actual_hash = [['Title', 'Status', 'Total amount']]
    invoices_table = page.find(:xpath, '/html/body/table[4]/tbody/tr/td[2]/div[4]/form/table/tbody/tr[1]/td/div/table')
    invoices_table.all('tr').drop(2).each do |table_row|
      invoice_number = table_row.all('td')[2].find('a').text
      status = table_row.all('td')[4].text
      invoice_amount = table_row.all('td')[5].text
      actual_hash << [invoice_number, status, invoice_amount]
    end

    begin
      table.diff! actual_hash
    rescue
      step %{I go to the vTiger Invoices tab}
      raise "Invoices do not match, found: #{actual_hash}"
    end
  }
end