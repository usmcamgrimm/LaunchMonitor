Rails.application.config.after_initialize do
  if Rails.cache.read("spacedevs:launches:upcoming").blank?
    puts "!!! Launch cache empty on startup. Priming the cache..."
    RefreshLaunchesJob.perform_later
  end
end
