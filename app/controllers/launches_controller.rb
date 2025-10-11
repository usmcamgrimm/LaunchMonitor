class LaunchesController < ApplicationController
  def index
    response = HTTParty.get("https://lldev.thespacedevs.com/2.2.0/launch/upcoming/")
    # response = HTTParty.get("https://ll.thespacedevs.com/2.3.0/launches/upcoming/")
    @launchData = parse_data(response)
    @locations = @launchData.map { |launch| launch[:location] }.uniq

    # --- Handle Preferences ---
    case params[:commit]
    when "apply"
      if params[:locations].present?
        session[:selected_locations] = params[:locations]
      end
    when "reset"
      session.delete(:selected_locations)
    end

    selected_locations = session[:selected_locations]

    # Apply saved preferences if any
    if selected_locations.present?
      @launchData = @launchData.select { |launch| selected_locations.include?(launch[:location]) }
    end
  end

  private

  def parse_data(response)
    results = response.parsed_response["results"] rescue []
    return [] if results.nil?

    results.map do |launch|
      {
        image: launch["image"] || "stock_launch.jpg",
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
