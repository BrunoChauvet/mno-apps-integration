module Connec
  class ClientV1
    def client
      @client ||= Faraday.new(:url => 'http://connec.maestrano.io')
      @client
    end

    def organizations
      response = client.get "/v1/dolibarr.app.dev.maestrano.io/organizations" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def people
      response = client.get "/v1/dolibarr.app.dev.maestrano.io/persons" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end

    def items
      response = client.get "/v1/dolibarr.app.dev.maestrano.io/items" do |request|
        request.headers['MNO-TRUSTED'] = 'true'
      end
      JSON.parse(response.body)
    end
  end
end
