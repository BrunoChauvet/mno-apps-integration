When /^I go to the Products and Service tab$/ do
  page.find(:xpath, "/html/body/div[3]/div/ul/li[3]/div[2]/a[1]").click
end

When /^I create a new product$/ do |table|
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[3]/a").click
  
  table.hashes.each do |row|
		fill_in 'ref', :with => row['Reference']
    fill_in 'libelle', :with => row['Name']
    fill_in 'price', :with => row['Price']
    select('Inc. tax', :from => 'price_base_type')
    select('10%', :from => 'tva_tx')
	end

  click_button 'Create'
end

When /^I display the list of Products$/ do
  step %{I go to the Products and Service tab}
  page.find(:xpath, "/html/body/div[5]/div[1]/div/div[1]/div[4]/a").click
end

When /^I select the Product "(.*?)"$/ do |item|
  items_list = page.find('table.liste')
  item_link = items_list.all('a').select{ |a| a.text == item }.first
  raise "Product #{item} not found in the list" unless item_link

  item_link.click
end
