require "application_system_test_case"
require "webmock/minitest"

class FilterTest < ApplicationSystemTestCase
  setup do
    body = file_fixture("spacedevs_upcoming.json").read
    stub_request(:get, %r{ll.thespacedevs.com.*launches/upcoming})
      .to_return(status: 200, body: body, headers: { "Content-Type" => "application/json" })
  end

  test "clicking reset unchecks all boxes" do
    visit root_path
    click_on "Toggle Preferences"
    check "Cape Canaveral"
    click_on "Reset"
    assert_no_selector "input[type=checkbox]:checked"
  end
end
