class LaunchesController < ApplicationController
  def index
    response = HTTParty.get("https://lldev.thespacedevs.com/2.2.0/launch/upcoming/")
    # response = HTTParty.get("https://ll.thespacedevs.com/2.3.0/launches/upcoming/")
    @launchData = parse_data(response)
  end

  private

  def parse_data(response)
    response["results"].map do |launch|
      {
        image: launch["image"],
        # image: launch.dig("image", "image_url") || "stock_launch.jpg",
        lsp: launch.dig("launch_service_provider", "name"),
        name: launch["name"],
        payload: launch.dig("mission", "name"),
        mission: launch.dig("mission", "description"),
        launch_date: launch["net"],
        status: launch.dig("status", "name"),
        location: launch.dig("pad", "location", "name")
      }
    end
  end
end
