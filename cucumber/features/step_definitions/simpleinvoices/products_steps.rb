When /^I go to the Products tab$/ do
  page.find(:xpath, "/html/body/div[5]/ul/li[4]/a").click
  page.find(:xpath, "/html/body/div[5]/div[4]/ul/li[1]/a").click
end

Then /^I should see the Product "(.*?)"$/ do |product_name|
  eventually {
    product_cell = nil
    product_list = page.find('#manageGrid')
    product_list.all('tr').each do |row|
      row.all('td div').each do |cell|
        if cell.text == product_name
          product_cell ||= cell
        end
      end
    end

    unless product_cell
      visit current_path
      raise "Product #{product_name} not found"
    end
  }
end

