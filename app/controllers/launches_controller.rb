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
        mission: launch['mission'],
        deescription: launch['description'],
        rocketname: launch['rocketname'],
        launch_date: launch['launch_date'],
        status: launch['status'],
        location: launch['location']
      }
    end
  end
end
