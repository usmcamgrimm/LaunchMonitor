class ApiClient
  include HTTParty

  # Use the ENV variable, default to the production URL if not set
  BASE_URI =  ENV.fetch("SPACE_DEVS_BASE_URI", "https://ll.thespacedevs.com/2.2.0/launch/upcoming/")

  def fetch_launches
    response = HTTParty.get(BASE_URI)

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
