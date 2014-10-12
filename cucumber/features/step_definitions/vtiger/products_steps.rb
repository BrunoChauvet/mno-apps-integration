When /^I go to the vTiger Products tab$/ do
  page.find(:xpath, "/html/body/table[2]/tbody/tr/td[2]/table/tbody/tr/td[12]/a").click
end

Then /^I should see the following Products in vTiger$/ do |table|
  eventually {
    actual_hash = [['Product name', 'Product price']]
    products_table = page.find(:xpath, '/html/body/table[4]/tbody/tr/td[2]/div[4]/form/table/tbody/tr[1]/td/div/table')
    products_table.all('tr').drop(2).each do |table_row|
      product_name = table_row.all('td')[2].first('a').text
      product_price = table_row.all('td')[7].text
      actual_hash << [product_name, product_price]
    end

    begin
      table.diff! actual_hash
    rescue
      visit current_path
      raise "Prodcuts do not match, found: #{actual_hash}"
    end
  }
end