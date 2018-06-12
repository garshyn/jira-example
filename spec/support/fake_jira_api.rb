RSpec.configure do |config|
  config.before(:each) do
    response = {
      "fields" => {
        "id" => 1,
        "summary" => "Issue",
        "description" => "Description",
      }
    }
    response_2 = {
      "fields" => {
        "id" => 1,
        "summary" => "Edited",
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

    stub_request(:get, "https://metrics-challenge.atlassian.net/rest/api/2/issue/10003").
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

    stub_request(:put, "https://metrics-challenge.atlassian.net/rest/api/2/issue/1").
      with(
        body: '{"fields":{"summary":"Edited"}}',
        headers: {
          'Accept'=>'application/json',
          'Content-Type'=>'application/json',
        }
      ).
      to_return(
        status: 200,
        body: response_2.to_json,
        headers: {}
      )

    stub_request(:post, "https://metrics-challenge.atlassian.net/rest/api/2/issue").
      with(
        body: '{"fields":{"summary":"Issue","description":"Description","project":{"id":"10001"},"issuetype":{"id":"10003"}}}',
        headers: {
       	  'Accept'=>'application/json',
       	  'Content-Type'=>'application/json',
        }).
      to_return(
        status: 200,
        body: response.to_json,
        headers: {}
      )
  end
end
