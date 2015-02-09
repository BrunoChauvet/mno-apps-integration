require 'faraday'

module Connec
  class ClientV1
    DOLIBAR_GROUP_ID = 'dolibarr.app.dev.maestrano.io'
    XERO_GROUP_ID    = 'sugarcrm.app.dev.maestrano.io'

    def client
      @client ||= Faraday.new(:url => 'http://connec.maestrano.io')
      @client
    end

    def set_company(row)
      data = {}
      data['id'] = row['Id'] if row['Id']
      data['name'] = row['Name'] if row['Name']
      data['currency'] = row['Currency'] if row['Currency']
      data['note'] = row['Note'] if row['Note']
      data['timezone'] = row['Timezone'] if row['Timezone']
      
      data['contacts'] = {}
      data['contacts']['address'] = {}

      if row['Billing Address']
        address_parts = row['Billing Address'].split(';')
        data['contacts']['address']['postalAddress'] = {}
        data['contacts']['address']['postalAddress']['streetAddress'] = address_parts[0] if address_parts.size > 0
        data['contacts']['address']['postalAddress']['locality'] = address_parts[1] if address_parts.size > 1
        data['contacts']['address']['postalAddress']['region'] = address_parts[2] if address_parts.size > 2
        data['contacts']['address']['postalAddress']['postalCode'] = address_parts[3] if address_parts.size > 3
        data['contacts']['address']['postalAddress']['country'] = address_parts[4] if address_parts.size > 4
      end

      if row['Shipping Address']
        address_parts = row['Shipping Address'].split(';')
        data['contacts']['address']['streetAddress'] = {}
        data['contacts']['address']['streetAddress']['streetAddress'] = address_parts[0] if address_parts.size > 0
        data['contacts']['address']['streetAddress']['locality'] = address_parts[1] if address_parts.size > 1
        data['contacts']['address']['streetAddress']['postalCode'] = address_parts[2] if address_parts.size > 2
        data['contacts']['address']['streetAddress']['region'] = address_parts[3] if address_parts.size > 3
        data['contacts']['address']['streetAddress']['country'] = address_parts[4] if address_parts.size > 4
      end

      data['contacts']['telephone'] = {}
      data['contacts']['telephone']['voice'] = row['Phone'] if row['Phone']
      
      data['contacts']['email'] = {'emailAddress' => row['Email']} if row['Email']
      data['contacts']['website'] = {'url' => row['Website']} if row['Website']

      response = client.post do |request|
        request.url "/v1/#{XERO_GROUP_ID}/company"
        request.headers['MNO-TRUSTED'] = 'true'
        request.headers['Content-Type'] = 'application/json'
        request.body = {'company'=>data}.to_json
      end
    end

    def organizations
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/organizations" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_organizations(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['name'] = row['Name'] if row['Name']
        data['entity'] = {'customer' => row['Type'].include?('Customer'), 'supplier' => row['Type'].include?('Supplier')} if row['Type']
        
        data['contacts'] = {}
        data['contacts']['address'] = {}
        data['contacts']['telephone'] = {}

        if row['Billing Address']
          address_parts = row['Billing Address'].split(';')
          data['contacts']['address']['postalAddress'] = {}
          data['contacts']['address']['postalAddress']['streetAddress'] = address_parts[0] if address_parts.size > 0
          data['contacts']['address']['postalAddress']['locality'] = address_parts[1] if address_parts.size > 1
          data['contacts']['address']['postalAddress']['region'] = address_parts[2] if address_parts.size > 2
          data['contacts']['address']['postalAddress']['postalCode'] = address_parts[3] if address_parts.size > 3
          data['contacts']['address']['postalAddress']['country'] = address_parts[4] if address_parts.size > 4
        end

        if row['Shipping Address']
          address_parts = row['Shipping Address'].split(';')
          data['contacts']['address']['streetAddress'] = {}
          data['contacts']['address']['streetAddress']['streetAddress'] = address_parts[0] if address_parts.size > 0
          data['contacts']['address']['streetAddress']['locality'] = address_parts[1] if address_parts.size > 1
          data['contacts']['address']['streetAddress']['postalCode'] = address_parts[2] if address_parts.size > 2
          data['contacts']['address']['streetAddress']['region'] = address_parts[3] if address_parts.size > 3
          data['contacts']['address']['streetAddress']['country'] = address_parts[4] if address_parts.size > 4
        end

        data['contacts']['telephone']['voice'] = row['Phone'] if row['Phone']

        data['contacts']['email'] = {'emailAddress' => row['Email']} if row['Email']
        data['contacts']['website'] = {'url' => row['Website']} if row['Website']

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/organizations"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end

    def people
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/persons" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_people(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['name'] = {'givenNames' => row['First name'], 'familyName' => row['Last name']}
        data['role'] = {'organization' => {'id' => row['Organziation Id']}} if row['Organziation Id']

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/persons"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end

    def accounts
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/accounts" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_accounts(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['name'] = row['Name'] if row['Name']
        data['code'] = row['Code'] if row['Code']
        data['description'] = row['Description'] if row['Description']
        data['currency'] = row['Currency'] if row['Currency']
        data['classification'] = row['Classification'] if row['Classification']
        data['type'] = row['Type'] if row['Type']
        data['subType'] = row['Sub Type'] if row['Sub Type']

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/accounts"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end

    def tax_codes
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/tax_codes" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_tax_codes(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['name'] = row['Name'] if row['Name']
        data['description'] = row['Description'] if row['Description']
        data['saleTaxRate'] = row['Sale Tax Rate'] if row['Sale Tax Rate']
        data['purchaseTaxRate'] = row['Purchase Tax Rate'] if row['Purchase Tax Rate']
        data['salesTaxes'] = {'name'=>row['Sale Tax Component Name'], 'rate'=>row['Sale Tax Component Rate']} if row['Sale Tax Component Name']
        data['purchaseTaxes'] = {'name'=>row['Purchase Tax Component Name'], 'rate'=>row['Purchase Tax Component Rate']} if row['Purchase Tax Component Name']

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/tax_codes"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end

    def items
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/items" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_items(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['name'] = row['Name'] if row['Name']
        data['code'] = row['Code'] if row['Code']
        data['description'] = row['Description'] if row['Description']
        data['type'] = row['Type'] if row['Type']

        data['sale'] = {'price'=>row['Sale Total Price'], 'netAmount'=>row['Sale Net Price'], 'taxAmount'=>row['Sale Tax Amount'],
                        'taxRate'=>row['Sale Tax Rate'], 'currency'=>row['Sale Currency']}
        data['purchase'] = {'price'=>row['Purchase Total Price'], 'netAmount'=>row['Purchase Net Price'], 'taxAmount'=>row['Purchase Tax Amount'],
                            'taxRate'=>row['Purchase Tax Rate'], 'currency'=>row['Purchase Currency']}

        data['saleTaxCode'] = {'id' => row['Sale Tax Code Id']}

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/items"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end

    def invoices
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/invoices" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_invoices(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['title'] = row['Title'] if row['Title']
        data['transactionNumber'] = row['Transaction Number'] if row['Transaction Number']
        data['transactionDate'] = Time.parse(row['Transaction Date']).to_i if row['Transaction Date']
        data['dueDate'] = Time.parse(row['Due Date']).to_i if row['Due Date']
        data['status'] = row['Status'] if row['Status']
        data['type'] = row['Type'] if row['Type']
        data['amount'] = {'price'=>row['Total Amount'], 'netAmount'=>row['Total Net Amount'], 'netAmount'=>row['Total Tax Amount'], 'currency'=>row['Currency']}
        data['balance'] = row['Balance'] if row['Balance']
        data['deposit'] = row['Deposit'] if row['Deposit']
        data['organization'] = {'id'=>row['Customer Id']} if row['Customer Id']

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/invoices"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end

    def add_invoice_lines(invoice_id, hashes)
      data = {}
      data['id'] = invoice_id
      data['invoiceLines'] = {}

      hashes.each do |row|
        data['invoiceLines'][row['Id']] = {
          'lineNumber'=>row['Line Number'],
          'quantity'=>row['Quantity'],
          'reductionPercent'=>row['Reduction Percent'],
          'unitPrice'=>{'price'=>row['Unit Price'], 'netAmount'=>row['Unit Net Price']},
          'totalPrice'=>{'price'=>row['Total Price'], 'netAmount'=>row['Total Net Price']},
          'item'=>{'id'=>row['Item Id']},
          'taxCode'=>{'id'=>row['Tax Code Id']}
        }
      end

      response = client.post do |request|
        request.url "/v1/#{XERO_GROUP_ID}/invoices"
        request.headers['MNO-TRUSTED'] = 'true'
        request.headers['Content-Type'] = 'application/json'
        request.body = data.to_json
      end
    end

    def payments
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/payments" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def employees
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/employees" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def add_employees(hashes)
      hashes.each do |row|
        data = {}
        data['id'] = row['Id'] if row['Id']
        data['name'] = {'givenNames' => row['First name'], 'familyName' => row['Last name']}
        data['employeeId'] = row['Employee ID'] if row['Employee ID']

        response = client.post do |request|
          request.url "/v1/#{XERO_GROUP_ID}/employees"
          request.headers['MNO-TRUSTED'] = 'true'
          request.headers['Content-Type'] = 'application/json'
          request.body = data.to_json
        end
      end
    end
  end
end
