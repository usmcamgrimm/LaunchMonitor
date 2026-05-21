require 'rails_helper'

RSpec.describe "Launches", type: :request do
  it "renders friendly error when upstream times out" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_timeout
    get root_path

    expect(response).to have_http_status(:success)
    expect(response.body).to match(/unable to reach TheSpaceDevs/i)
  end

  it "renders friendly error on 429" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_return(status: 429, body: "{}")
    get root_path

    expect(response).to have_http_status(:success)
  end
end
