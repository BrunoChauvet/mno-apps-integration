require 'faraday'

Then(/^Connec should contain the Organizations$/) do |table|
  client = Connec::ClientV1.new
  organizations = client.organizations

  row = table.hashes.first
  matching_organization = organizations.select do |organization|
    organization['name'] == row['Name']
  end

  raise "Organization not found" unless matching_organization
end

Then(/^Connec should contain the Contacts$/) do |table|
  client = Connec::ClientV1.new
  people = client.people

  row = table.hashes.first
  matching_organization = people.select do |person|
    person['name']['givenNames'] == row['First name']
    person['name']['familyName'] == row['Last name']
  end

  raise "Organization not found" unless matching_organization
end

Then(/^Connec should contain the Items$/) do |table|
  client = Connec::ClientV1.new
  items = client.items

  row = table.hashes.first
  matching_organization = items.select do |item|
    item['name'] == row['Product name']
    item['sale']['price'] == row['Product price']
  end

  raise "Organization not found" unless matching_organization
end
