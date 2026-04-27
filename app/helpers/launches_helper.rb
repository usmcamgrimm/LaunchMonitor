module LaunchesHelper
  def set_launch_date(launch_date)
    date = Date.parse(launch_date)
    date.strftime("%A, %b %-d")
  end

  def set_launch_time(launch_date)
    time = Time.parse(launch_date).in_time_zone(Time.zone)
    time.strftime("%l:%M%P")
  end

  def status_color(status)
    case status
    when "Go for Launch", "Launch Successful" then "text-green-500 hover:text-green-600"
    when "Launch in Flight", "Payload Deployed" then "text-sky-500 hover:text-sky-600"
    when "To Be Confirmed", "To Be Determined" then "text-orange-500 hover:text-orange-600"
    else "text-slate-200 hover:text-slate-400"
    end
  end
end
