require "test_helper"
require "webmock/minitest"

class LaunchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.cache.clear
  end

  teardown do
    Rails.cache.clear
  end

  test "shows friendly upstream error when refresh fails without cached launches" do
    stub_request(:get, %r{thespacedevs\.com}).to_timeout
    RefreshLaunchesJob.perform_now

    get root_url

    assert_response :success
    assert_match(/Unable to reach TheSpaceDevs API/i, response.body)
    assert_no_match(/No launches found/i, response.body)
  end

  test "keeps showing cached launches when a later refresh fails" do
    stub_request(:get, %r{thespacedevs\.com})
      .to_return(
        status: 200,
        body: {
          results: [
            {
              name: "Starlink Group 42",
              net: "2026-05-20T10:00:00Z",
              launch_service_provider: { name: "SpaceX" }
            }
          ]
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      ).then
      .to_timeout

    RefreshLaunchesJob.perform_now
    RefreshLaunchesJob.perform_now

    get root_url

    assert_response :success
    assert_match(/Starlink Group 42/i, response.body)
    assert_no_match(/Unable to reach TheSpaceDevs API/i, response.body)
  end
end
