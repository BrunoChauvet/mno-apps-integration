Given(/^Xero pushes the following data to Connec$/) do |table|
  client = Connec::ClientV1.new.client
  client.basic_auth('7877468b-aaeb-4129-a9c7-4711b2d32337', '87643da1-5386-4332-b4f0-2e474b8248f3')

  response = client.post do |request|
    request.url "/api/xrov2/admin/org-fbxd/organizations"
    request.headers['Content-Type'] = 'application/json'
    request.body = File.read("/home/bruno/Workspace/mno-apps-integration/cucumber/fixtures/xero/contact-01.json")
  end
end