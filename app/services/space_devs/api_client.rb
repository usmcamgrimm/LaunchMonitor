module SpaceDevs
  class ApiClient
    include HTTParty
    # Use the ENV variable and set a fallback in cases where the variable isn't already set.
    BASE_URI =  ENV.fetch("SPACE_DEVS_BASE_URI", "https://lldev.thespacedevs.com/2.2.0/launch/upcoming/")
    default_timeout 5 # set timeout to 5 seconds

    Result = Struct.new(:launches, :error, keyword_init: true) do
      def success? = error.nil?
    end

    def self.upcoming
      Rails.cache.fetch("spacedevs:launches:upcoming", expires_in: 5.minutes) do
        response = get(BASE_URI)
        if response.success?
          Result.new(launches: Array(response["results"]))
        else
          Rails.logger.warn("[SpaceDevs] upstream #{response.code}")
          Result.new(launches: [], error: :upstream_error)
        end
      end
    rescue HTTParty::Error, SocketError, Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED => e
      Rails.logger.warn("[SpaceDevs] network error: #{e.class}: #{e.message}")
      Result.new(launches: [], error: :network_error)
    end
  end
end
