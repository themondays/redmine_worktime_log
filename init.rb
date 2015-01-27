require 'redmine'
Redmine::Plugin.register :redmine_worktime_log do
  name 'Redmine Worktime Log'
  author 'Jared Denisov'
  description 'Worktime log will help arange spent time and prepare logs for each user.'
  version '0.0.2'
  url 'http://themondays.ca/redmine/plugins/worklog.git'
  author_url 'http://themondays.ca'

  requires_redmine :version_or_higher => '2.1.2'

  settings :default => {
    'show_in_projects' => true,
    'show_in_issues' => true,
    'show_in_welcome' => false,
    'show_toolbar_in_issue' => true,
  }, :partial => 'settings/worktime'

  permission :worktime, { :worktimelog => [:user_summary] }, :public => false

  project_module :worktime do
    permission :view_issue_summary, :worktimelog => :issue_summary
    permission :view_project_sumary, :worktimelog => :project_summary
    permission :view_user_sumary, :worktimelog => :user_summary
    permission :stopwatch_timer, :stopwatch => :timer
  end
  menu :project_menu, :worktime_log, {:controller => 'worktimelog', :action => 'project_summary'}, :caption => :label_worktime_project_nav, :param => :project_id
end

ActionDispatch::Callbacks.to_prepare do
  require 'redmine_worktime'
end
