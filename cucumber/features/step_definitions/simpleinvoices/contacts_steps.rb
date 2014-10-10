When /^I go to the Customers tab$/ do
  page.find(:xpath, "/html/body/div[5]/ul/li[3]/a").click
  page.find(:xpath, "/html/body/div[5]/div[3]/ul/li[1]/a").click
end

Then /^I should see the Customer "(.*?)"$/ do |customer_name|
  eventually {
    customer_cell = nil
    customer_list = page.find('#manageGrid')
    customer_list.all('tr').each do |row|
      row.all('td div').each do |cell|
        if cell.text == customer_name
          customer_cell ||= cell
        end
      end
    end
    raise "Customer #{customer_name} not found" unless customer_cell
  }
end

