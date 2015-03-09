Given(/^Connec contains the Company$/) do |table|
  client = Connec::ClientV1.new
  client.set_company table.hashes.first
end

Then(/^Connec should contain the Company$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    companies = client.companies

    table.hashes.each do |row|
      matching_company = companies.select do |company|
        company['name'] == row['Name']
        company['taxNumber'] == row['Tax Number'] if row['Tax Number']
        company['employerNumber'] == row['Employer Number'] if row['Employer Number']
        company['note'] == row['Notes'] if row['Notes']

        company['contacts']['email']['emailAddress'] == row['Email'] if row['Email']

        company['contacts']['address']['postalAddress']['streetAddress'] == row['Address 1'] if row['Address 1']
        company['contacts']['address']['postalAddress']['streetAddress2'] == row['Address 2'] if row['Address 2']
        company['contacts']['address']['postalAddress']['locality'] == row['City'] if row['City']
        company['contacts']['address']['postalAddress']['region'] == row['State'] if row['State']
        company['contacts']['address']['postalAddress']['postalCode'] == row['Zip'] if row['Zip']
        company['contacts']['address']['postalAddress']['country'] == row['Country'] if row['Country']

        company['contacts']['telephone']['voice'] == row['Phone'] if row['Phone']
        company['contacts']['telephone']['fax'] == row['Fax'] if row['Fax']
      end.first

      raise "Company not found: #{row}" unless matching_company
    end
  }
end

Given(/^Connec contains the Organizations$/) do |table|
  client = Connec::ClientV1.new
  client.add_organizations table.hashes
end

Then(/^Connec should contain the Organizations$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    organizations = client.organizations

    table.hashes.each do |row|
      matching_organization = organizations.select do |organization|
        organization['name'] == row['Name']
      end.first

      raise "Organization not found: #{row}" unless matching_organization
    end
  }
end

Given(/^Connec contains the Contacts$/) do |table|
  client = Connec::ClientV1.new
  client.add_people table.hashes
end

Then(/^Connec should contain the Contacts$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    people = client.people

    table.hashes.each do |row|
      matching_contact = people.select do |person|
        person['name']['givenNames'] == row['First name']
        person['name']['familyName'] == row['Last name']
      end.first

      raise "Person not found: #{row}" unless matching_contact
    end
  }
end

Given(/^Connec contains the Accounts$/) do |table|
  client = Connec::ClientV1.new
  client.add_accounts table.hashes
end

Then(/^Connec should contain the Accounts$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    accounts = client.accounts

    table.hashes.each do |row|
      matching_account = accounts.select do |account|
        account['name'] == row['Name']
        account['code'] == row['Code']
        account['description'] == row['Description'] if row['Description']
        account['currency'] == row['Currency'] if row['Currency']
        account['classification'] == row['Classification'] if row['Classification']
        account['type'] == row['Type'] if row['Type']
        account['subType'] == row['SubType'] if row['SubType']
      end.first

      raise "Account not found: #{row}" unless matching_account
    end
  }
end

Given(/^Connec contains the Tax Codes$/) do |table|
  client = Connec::ClientV1.new
  client.add_tax_codes table.hashes
end

Then(/^Connec should contain the Tax Codes$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    tax_codes = client.tax_codes

    table.hashes.each do |row|
      matching_tax_code = tax_codes.select do |item|
        item['name'] == row['Tax Code name']
        item['description'] == row['Tax Code description'] if row['Tax Code description']
      end.first

      raise "Tax Code not found: #{row}" unless matching_tax_code
    end
  }
end

Given(/^Connec contains the Items$/) do |table|
  client = Connec::ClientV1.new
  client.add_items table.hashes
end

Then(/^Connec should contain the Items$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    items = client.items

    table.hashes.each do |row|
      matching_item = items.select do |item|
        item['name'] == row['Product name']
        item['sale']['price'] == row['Product price']
      end.first

      raise "Item not found: #{row}" unless matching_item
    end
  }
end

Given(/^Connec contains the Invoices$/) do |table|
  client = Connec::ClientV1.new
  client.add_invoices table.hashes
end

Given(/^Connec Invoice "(.*?)" contains the Invoice Lines$/) do |invoice_id, table|
  client = Connec::ClientV1.new
  client.add_invoice_lines(invoice_id, table.hashes)
end


Then(/^Connec should contain the Invoices$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    invoices = client.invoices

    table.hashes.each do |row|
      matching_invoice = invoices.select do |invoice|
        invoice['transactionNumber'] == row['Number']
        Time.at(invoice['transactionDate']).strftime('%F') == row['Date'] if row['Date']
        Time.at(invoice['dueDate']).strftime('%F') == row['Due'] if row['Due']
        invoice['status'] == row['Status'] if row['Status']
        invoice['amount']['price'].to_s == row['Total amount'] if row['Total amount']
      end.first
      raise "Invoice not found: #{row}" unless matching_invoice
    end
  }
end

Then(/^Connec should contain only the Invoices$/) do |table|
  client = Connec::ClientV1.new
  
  eventually {
    invoices = client.invoices

    actual_invoices = []
    actual_invoices << ['Number', 'Date', 'Due', 'Status', 'Total amount']
    invoices.each { |invoice| actual_invoices << [
      invoice['transactionNumber'],
      Time.at(invoice['transactionDate']).strftime('%F'),
      Time.at(invoice['dueDate']).strftime('%F'),
      invoice['status'],
      invoice['amount']['price'].to_s
    ] }

    table.diff! actual_invoices
  }
end

Given(/^Connec contains the Employees$/) do |table|
  client = Connec::ClientV1.new
  client.add_employees table.hashes
end

Then(/^Connec should contain the Employees$/) do |table|
  client = Connec::ClientV1.new
  eventually {
    employees = client.employees

    table.hashes.each do |row|
      matching_employee = employees.select do |employee|
        employee['name']['givenNames'] == row['First name']
        employee['name']['familyName'] == row['Last name']
        employee['employeeId'] == row['Employee ID']

        next(false) unless row['Gender'].nil? || employee['gender'] == row['Gender']
        next(false) unless row['Job Title'].nil? || employee['jobTitle'] == row['Job Title']
        next(false) unless row['SSN'].nil? || employee['socialSecurityNumber'] == row['SSN']

        next(false) unless row['Address Street 1'].nil? || employee['contacts']['address']['streetAddress']['streetAddress'] == row['Address Street 1']
        next(false) unless row['Address Street 2'].nil? || employee['contacts']['address']['streetAddress']['streetAddress2'] == row['Address Street 2']
        next(false) unless row['City'].nil? || employee['contacts']['address']['streetAddress']['locality'] == row['City']
        next(false) unless row['State'].nil? || employee['contacts']['address']['streetAddress']['region'] == row['State']
        next(false) unless row['Country'].nil? || employee['contacts']['address']['streetAddress']['country'] == row['Country']

        next(false) unless row['Work Email'].nil? || employee['contacts']['email']['address'] == row['Work Email']
        next(false) unless row['Other Email'].nil? || employee['contacts']['email']['address2'] == row['Other Email']

        next(false) unless row['Home Telephone'].nil? || employee['contacts']['telephone']['voice'] == row['Home Telephone']
        next(false) unless row['Work Telephone'].nil? || employee['contacts']['telephone']['voice2'] == row['Work Telephone']
        next(false) unless row['Mobile'].nil? || employee['contacts']['telephone']['mobile'] == row['Mobile']

        next(true)
      end.first
      raise "Employee not found: #{row}" unless matching_employee
    end
  }
end