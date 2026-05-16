class LaunchesController < ApplicationController
  def index
    client = ApiClient.new
    @launchData = client.fetch_launches

    @locations = @launchData.map { |launch| launch[:location] }.uniq

    if params[:locations].present?
      @launchData = @launchData.select { |launch| params[:locations].include?(launch[:location]) }
    end
  end
end
