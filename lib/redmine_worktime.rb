# Redmine Worktime Log Hooks
# require 'redmine_worktime/patches/project_patch'
require 'redmine_worktime/helpers/worktime_helper'
require 'redmine_worktime/hooks/view_layout_hook'
require 'redmine_worktime/hooks/view_sidebar_hook'
if !!Setting.plugin_redmine_worktime_log[:show_toolbar_in_issue]
  require 'redmine_worktime/hooks/view_issue_hook'
end

module RedmineWorktime
  module Hooks
    class ViewLayoutsBaseHook < Redmine::Hook::ViewListener
      #<%= javascript_include_tag 'jquery.stopwatch.js', 'timer', :plugin => 'redmine_worktime_log' %>
      render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag :redmine_worktime_log, :plugin => 'redmine_worktime_log' %>"
    end
  end
end
