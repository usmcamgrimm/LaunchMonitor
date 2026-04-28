class LaunchesController < ApplicationController
  def index
    response = HTTParty.get("https://ll.thespacedevs.com/2.3.0/launches/upcoming/")
    @launch_data = parse_data(response)
    @locations = @launch_data.map { |l| l[:location] }.uniq
    @launch_data = filter_by_location(@launch_data)
  end

  private

  def filter_by_location(launches)
    return launches if params[:locations].blank?
    launches.select { |l| params[:locations].include?(l[:location]) }
  end

  def parse_data(response)
    response["results"].map do |launch|
      {
        image: launch["image"].is_a?(Hash) ? launch["image"]["image_url"] : launch["image"] || "stock_launch.jpg",
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
