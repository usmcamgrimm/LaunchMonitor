require 'rails_helper'

RSpec.describe "Launches", type: :request do
  before do
    Rails.cache.clear
  end

  it "renders friendly error when upstream times out" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_timeout
    RefreshLaunchesJob.perform_now

    get root_path

    expect(response).to have_http_status(:success)
    expect(response.body).to match(/No launches found/i)
  end

  it "renders friendly error on 429" do
    stub_request(:get, %r{ll.thespacedevs.com}).to_return(status: 429, body: "{}")
    get root_path

    expect(response).to have_http_status(:success)
  end

  it "caches the API response and only queries the API once per multiple calls" do
    stub_response = stub_request(:get, %r{ll.thespacedevs.com}).to_return(status: 200, body: { results: [] }.to_json, headers: { 'Content-Type' => 'application/json' })

    Rails.cache.clear

    RefreshLaunchesJob.perform_now

    get root_path
    get root_path
    get root_path

    expect(response).to have_http_status(:success)
    expect(stub_response).to have_been_requested.once
  end
end
