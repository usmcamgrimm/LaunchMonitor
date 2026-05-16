module LaunchesHelper
  def status_color(status)
    case status
    when "Go for Launch", "Launch Successful" then "text-green-500 hover:text-green-600"
    when "Launch in Flight", "Payload Deployed" then "text-sky-500 hover:text-sky-600"
    when "To Be Confirmed", "To Be Determined" then "text-orange-500 hover:text-orange-600"
    when "Launch Failure" then "text-red-500 hover:text-red-600"
    else "text-slate-200 hover:text-slate-400"
    end
  end
end
