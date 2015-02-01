module RedmineWorktime
  module Helper
    def time_to_sec(t)
      s = t.split(":").map{|s| s.to_i}
      return (s[0]*3600) + (s[1]*60) + s[2]
    end
    # helper_method :to_time
    def to_time(t)
      seconds = t % 60
      minutes = (t / 60) % 60
      hours = t / (60 * 60)
      return format("%02d:%02d:%02d", hours, minutes, seconds)
    end
  end
end

ActionView::Base.send :include, RedmineWorktime::Helper