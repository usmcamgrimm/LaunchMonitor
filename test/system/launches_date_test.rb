require "application_system_test_case"

class LaunchesDateTest < ApplicationSystemTestCase
  setup do
    body = file_fixture("spacedevs_upcoming.json").read
    stub_request(:get, %r{ll.thespacedevs.com.*launches/upcoming})
      .to_return(status: 200, body: body, headers: { "Content-Type" => "application/json" })
  end

  test "stimulus controller formats ISO string into local human-readable date and time" do
    visit root_path
    assert_selector "time[data-controller='localtime']", text: "Fri, May 1 - 8:00 AM"
  end
end
