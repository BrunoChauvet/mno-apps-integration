Given(/^I go to the Organization General Information in OrangeHRM$/) do
  page.find('#menu_admin_viewAdminModule').click
  page.find('#menu_admin_Organization').hover
  page.find('#menu_admin_viewOrganizationGeneralInformation', visible: true).click
end

Given(/^I update the Organization General Information in OrangeHRM$/) do |table|
  page.find('#btnSaveGenInfo').click

  table.hashes.each do |row|
    fill_in 'organization_name', :with => row['Name']
    fill_in 'organization_taxId', :with => row['Tax ID']
    fill_in 'organization_registraionNumber', :with => row['Registration Number']
    fill_in 'organization_phone', :with => row['Phone']
    fill_in 'organization_fax', :with => row['Fax']
    fill_in 'organization_email', :with => row['Email']
    fill_in 'organization_street1', :with => row['Address 1']
    fill_in 'organization_street2', :with => row['Address 2']
    fill_in 'organization_city', :with => row['City']
    fill_in 'organization_province', :with => row['State']
    fill_in 'organization_zipCode', :with => row['Zip']
    select(row['Country'], :from => 'organization_country')
    fill_in 'organization_note', :with => row['Notes']
  end

  page.find('#btnSaveGenInfo').click
end