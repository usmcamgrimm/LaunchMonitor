class RefreshLaunchesJob < ApplicationJob
  queue_as :default
  LAUNCHES_CACHE_KEY = "spacedevs:launches:upcoming"
  ERROR_CACHE_KEY = "spacedevs:launches:upcoming:error"

  def perform
    result = SpaceDevs::ApiClient.upcoming
    if result.success?
      Rails.cache.write(LAUNCHES_CACHE_KEY, result.launches, expires_in: 30.minutes)
      Rails.cache.delete(ERROR_CACHE_KEY)
    else
      Rails.cache.write(ERROR_CACHE_KEY, result.error, expires_in: 30.minutes)
    end
  end
end
