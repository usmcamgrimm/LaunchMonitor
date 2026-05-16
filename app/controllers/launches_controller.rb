class LaunchesController < ApplicationController
  def index
    result = SpaceDevs::ApiClient.upcoming
    @error = result.error
    @launch_data = parse_data(result.launches)
    @locations = @launch_data.map { |launch| launch[:location] }.uniq

    if params[:locations].present?
      @launch_data = @launch_data.select { |launch| params[:locations].include?(launch[:location]) }
    end
  end

  private

  def parse_data(response)
    response.map do |launch|
      {
        image: launch["image"].is_a?(Hash) ? launch["image"]["image_url"] : launch["image"] || "stock_launch.jpg",
        lsp: launch.dig("launch_service_provider", "name") || "No agency provided",
        name: launch["name"],
        payload: launch.dig("mission", "name") || "Unidentified payload",
        mission: launch.dig("mission", "description") || "Mission details not set",
        launch_date: launch["net"],
        status: launch.dig("status", "name") || "Status update pending",
        description: launch.dig("status", "description") || "",
        location: launch.dig("pad", "location", "name") || "Unknown location set for launch"
      }
    end
  end
end
