class LaunchesController < ApplicationController
  def index
    response = HTTParty.get('https://lldev.thespacedevs.com/2.2.0/launch/upcoming/')
    @launchData = parse_data(response)
  end

  private

  def parse_data(response)
    response['results'].map do |launch|
      {
        name: launch['name'],
        mission: launch.dig('mission', 'description'),
        launch_date: launch['net'],
        status: launch.dig('status', 'name'),
        location: launch.dig('pad', 'location', 'name')
      }
    end
  end
end
