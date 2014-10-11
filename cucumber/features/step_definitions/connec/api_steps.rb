require 'faraday'

Then(/^Connec should contain the Organization$/) do |table|
  client = Connec::ClientV1.new
  organizations = client.organizations

  row = table.hashes.first
  matching_organization = organizations.select do |organization|
    organization['name'] == row['Name']
  end

  raise "Organization not found" unless matching_organization
end