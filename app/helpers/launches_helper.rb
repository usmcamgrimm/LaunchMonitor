module LaunchesHelper
  def set_launch_date(launch_date)
    date = Date.parse(launch_date)
    date.strftime("%A, %d/%m/%Y")
  end

  def set_launch_time(launch_date)
    time = Time.parse(launch_date)
    time.strftime("%I:%m%p")
  end
end
