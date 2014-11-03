require 'faraday'

module Connec
  class ClientV1
    DOLIBAR_GROUP_ID = 'dolibarr.app.dev.maestrano.io'
    XERO_GROUP_ID    = 'cld-9prf'

    def client
      @client ||= Faraday.new(:url => 'http://connec.maestrano.io')
      @client
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
        data['name'] = {'givenNames' => row['First Name'], 'familyName' => row['Last Name']}
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

    def add_account(hashes)
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

    def items
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/items" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def invoices
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/invoices" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def payments
      response = client.get "/v1/#{DOLIBAR_GROUP_ID}/payments" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end
  end
end
