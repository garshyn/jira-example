RSpec.configure do |config|
  config.before(:each) do
    response = {
      "fields" => {
        "id" => 1,
        "summary" => "Issue",
        "description" => "Description",
      }
    }

    stub_request(:get, "https://metrics-challenge.atlassian.net/rest/api/2/issue/1").
      with(
        headers: {
     	    'Accept'=>'application/json',
        }
      ).
      to_return(
        status: 200,
        body: response.to_json,
        headers: {},
      )
  end
end
