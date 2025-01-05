class LaunchesController < ApplicationController
  def index
    # response = HTTParty.get("https://lldev.thespacedevs.com/2.2.0/launch/upcoming/")
    response = HTTParty.get("https://ll.thespacedevs.com/2.3.0/launches/upcoming/")
    @launchData = parse_data(response)
    @locations = @launchData.map { |launch| launch[:location] }.uniq

    if params[:locations].present?
      @launchData = @launchData.select { |launch| params[:locations].include?(launch[:location]) }
    end
  end

  private

  def parse_data(response)
    response["results"].map do |launch|
      {
        # image: launch["image"],
        image: launch.dig("image", "image_url") || "stock_launch.jpg",
        lsp: launch.dig("launch_service_provider", "name") || "No agency provided",
        name: launch["name"],
        payload: launch.dig("mission", "name") || "Unidentified payload",
        mission: launch.dig("mission", "description") || "Mission details not set",
        launch_date: launch["net"],
        status: launch.dig("status", "name") || "Status update pending",
        location: launch.dig("pad", "location", "name") || "Unknown location set for launch",
        hold_reason: launch["holdreason"],
        fail_reason: launch["failreason"]
      }
    end
  end
end
