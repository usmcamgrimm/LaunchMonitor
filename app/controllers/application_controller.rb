class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_time_zone

  private

  def set_time_zone
    timezone = cookies[:timezone]
    Rails.logger.debug "Timezone cookie: #{timezone}"
    Time.zone = timezone || "UTC"
    Rails.logger.debug "Timezone set to: #{Time.zone.name}"
  end
end
