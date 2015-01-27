module WorktimelogHelper
  def time_to_sec(t)
    s = t.split(":").map{|s| s.to_i}
    return (s[0]*3600) + (s[1]*60) + s[2]
  end
end
