require "test_helper"
require "webmock/minitest" # Ensures WebMock hooks into Minitest assertions

class LaunchesControllerTest < ActionDispatch::IntegrationTest
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
