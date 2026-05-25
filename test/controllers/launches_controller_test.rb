require "test_helper"
require "webmock/minitest" # Ensures WebMock hooks into Minitest assertions

class LaunchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    body = file_fixture("spacedevs_upcoming.json").read
    stub_request(:get, %r{ll.thespacedevs.com.*launches/upcoming})
      .to_return(status: 200, body: body, headers: { "Content-Type" => "application/json" })
  end

  test "index renders upcoming launches" do
    get root_path
    assert_response :success
    assert_match "Falcon 9 | Starlink", response.body
    assert_match "SpaceX", response.body
  end

  test "filters by location" do
    get root_path, params: { locations: [ "Kennedy Space Center" ] }
    assert_response :success
    assert_no_match "Falcon 9 | Starlink", response.body
  end

  test "renders gracefully when upstream 500s" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_return(status: 500)
    get root_path
    assert_response :success
  end

  test "renders gracefully when upstream times out" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_timeout
    get root_path
    assert_response :success
  end

  test "renders friendly error when upstream times out" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_timeout
    get root_path
    assert_response :success
    assert_match(/unable to reach TheSpaceDevs/i, response.body)
  end

  test "renders friendly error on 429" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_return(status: 429, body: "{}")
    get root_path
    assert_response :success
  end
end
