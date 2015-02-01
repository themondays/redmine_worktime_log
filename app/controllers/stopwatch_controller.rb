class StopwatchController < ApplicationController

  unloadable

  # before_filter :authorize

  respond_to :html, :js

  def get_started
    #Hope God will excuse me for using map this way 
    Worktimelog.where({:user_id => User.current.id, :flag => 0}).limit(1).map { |w| {started: w.started, issue_id: w.issue_id} }
  end

  def get_old_started
    Worktimelog.where({:user_id => User.current.id, :flag => 0})
  end

  def update_time_entry(t,id)
    now = Time.now.in_time_zone(User.current.time_zone).getutc
    project = Issue.where(:id => id).pluck(:project_id)
    te = TimeEntry.new(
      :project_id => project[0],
      :user_id => User.current.id,
      :issue_id => id,
      :hours => t.to_i/3600,
      :comments => 'Captured time',
      :activity_id => 1,
      :spent_on => User.current.today,
      :tyear => now.strftime('%Y'),
      :tmonth => now.strftime('%M'),
      :tweek => now.strftime('%U'),
      :created_on => now,
      :updated_on => now
    )
    te.save
  end

  def time_to_sec(t)
    s = t.split(":").map{|s| s.to_i}
    return (s[0]*3600) + (s[1]*60) + s[2]
  end

  def _start
      query = {
        :issue_id => params[:id],
        :user_id => User.current.id,
        :started => Time.now.in_time_zone(User.current.time_zone).getutc,
        :flag => 0
      }
      Worktimelog.create(query)
  end
  def _stop
    target = get_started[0]
    if target[:issue_id]
      now = Time.now.in_time_zone(User.current.time_zone).getutc
      started = time_to_sec(Time.at(now-Time.parse(target[:started].to_s)).strftime('%H:%M:%S'))
      @worklog = Worktimelog.where({:user_id => User.current.id, :flag => 0})
      spent_time = time_to_sec(Time.at(now-Time.at(Time.parse(target[:started].to_s))).utc.strftime('%R:%S'))
      @worklog.update_all("finished = '#{now}', total = '#{spent_time}', flag = 1")
      if target[:issue_id]
        update_time_entry(spent_time,target[:issue_id])
      end
    end
  end

  def timer
    @success = false
    if params[:state] == "start" && params[:id]
      @success = true
      _start
      if params[:back] == "true"
        redirect_to :back
      end

    end

    if params[:state] == "stop"
      @success = true
      _stop
      if params[:back] == "true"
        redirect_to :back
      end
    end
  end
  def snapup
    _stop
    _start

    issue = Issue.find(params[:id])
    issue.assigned_to_id = User.current.id
    issue.save

    if params[:back] == 'true'
      redirect_to :back
    end
  end

end
