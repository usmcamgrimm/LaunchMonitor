module LaunchesHelper
  def set_launch_date(launch_date)
    date = Date.parse(launch_date)
    date.strftime("%A, %b %-d")
  end

  def set_launch_time(launch_date)
    time = Time.parse(launch_date).in_time_zone(Time.zone)
    time.strftime("%l:%M%P")
  end
end
