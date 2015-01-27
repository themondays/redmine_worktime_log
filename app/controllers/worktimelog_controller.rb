class WorktimelogController < ApplicationController

  unloadable

  layout 'base'

  before_filter :find_project, :authorize, :only  => :project_summary

  respond_to :html, :js

  helper :issue_relations
  include IssueRelationsHelper
  include IssuesHelper

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_issue
    @project = Issue.find(params[:id])
  end

  def find_user
    @project = User.find(params[:user_id])
  end

  def new
    @worklog = Worktimelog.new
  end

  def index
  end

  def worklog
  end

  def timer
    @success = false
    if params[:state] == "start" && params[:id]
      @success = true
      @lv = {
        :issue_id => params[:id],
        :user_id => User.current.id,
        :started => Time.now.getutc,
        :flag => 0
      }
      logger.debug(@lv)
      @worklog = Worktimelog.create(@lv)
    end

    if params[:state] == "stop"
      @success = true
      @worklog = Worktimelog.where({:user_id => User.current.id, :flag => 0})
      @worklog.update_all(:finished => Time.now.getutc, :flag => 1)
    end
  end

  def get_worktime(query)
  end

  def issue_summary
    @date = Time.now

    where_query = "issue_id = #{params[:issue_id]} AND flag = 1"

    if (params[:started] && params[:finished])
      where_query += "AND (started, finished) OVERLAPS ('#{params[:started]}'::DATE, '#{params[:finished]}'::DATE)"
    end

    @summary = Worktimelog.joins([{issue: :project},:user]).select('
      issue_id,
      user_id,
      started,
      finished,
      total,
      flag,
      issues.project_id as project_id,
      issues.subject as subject,
      users.firstname as firstname,
      users.lastname as lastname
    ').
    where(where_query).
    order("
      finished DESC
    ")
    if ( params[:started] || params[:finished] )
      if ( params[:started] )
        @summary.where("started::text LIKE '#{params[:started]}%'")
      end
      if ( params[:finished] )
        @summary.where("finished::text LIKE '#{params[:finished]}%'")
      end
    else
      @summary.limit(100)
    end
  end

  def project_summary
    @date = Time.now

    where_query = "projects.identifier = '#{params[:project_id]}' AND flag = 1"

    if (params[:started] && params[:finished])
      where_query += "AND (started, finished) OVERLAPS ('#{params[:started]}'::DATE, '#{params[:finished]}'::DATE)"
    end

    @summary = Worktimelog.joins([{issue: :project},:user]).select('
      issue_id,
      user_id,
      started,
      finished,
      total,
      flag,
      issues.project_id as project_id,
      issues.subject as subject,
      users.firstname as firstname,
      users.lastname as lastname
    ').
    where(where_query).
    order("
      finished DESC
    ")
    if ( params[:started] || params[:finished] )
      if ( params[:started] )
        @summary.where("started::text LIKE '#{params[:started]}%'")
      end
      if ( params[:finished] )
        @summary.where("finished::text LIKE '#{params[:finished]}%'")
      end
    else
      @summary.limit(100)
    end  end

  def user_summary
    @date = Time.now
    @where_query = "user_id = #{params[:id]} AND flag = 1"
    @user = User.find(params[:id])
    if (params[:started] && params[:finished])
      @where_query += "AND (started, finished) OVERLAPS ('#{params[:started]}'::DATE, '#{params[:finished]}'::DATE)"
    end
    @summary = Worktimelog.joins(issue: :project).select('
      issue_id,
      user_id,
      started,
      finished,
      total,
      flag,
      issues.project_id as project_id,
      issues.subject as subject,
      projects.name as project_name,
      projects.identifier as project_identifier
    ').where(@where_query).
    order("
      finished DESC
    ")
    if ( params[:started] || params[:finished] )
      if ( params[:started] )
        @summary.where("started::text LIKE '#{params[:started]}%'")
      end
      if ( params[:finished] )
        @summary.where("finished::text LIKE '#{params[:finished]}%'")
      end
    else
      @summary.limit(100)
    end
  end

  def ranks
  end

  def time_to_sec(t)
    s = t.split(":").map{|s| s.to_i}
    return (s[0]*3600) + (s[1]*60) + s[2]
  end

private
  def worklog_params
    params.require(:worklog).permit(:issue_id)
  end

end
