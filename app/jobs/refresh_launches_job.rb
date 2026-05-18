class RefreshLaunchesJob < ApplicationJob
  queue_as :default

  def perform
    result = SpaceDevs::ApiClient.upcoming
    if result.success?
      Rails.cache.write("spacedevs:launches:upcoming", result.launches, expires_in: 30.minutes)
    end
  end
end
