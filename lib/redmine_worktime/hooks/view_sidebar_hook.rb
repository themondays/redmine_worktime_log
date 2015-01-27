module RedmineWorktime
  module Hooks
    class ViewSidebarHook < Redmine::Hook::ViewListener
      include MyHelper

      require_dependency 'projects_helper'
      def projects_list
        Project.
          limit(10).
          to_a
      end
      def issues_list
        Issue.visible.open.
          select("id,subject,project_id,p.name as project_name").
          where(:assigned_to_id => ([User.current.id] + User.current.group_ids)).
          includes(:status, :project, :tracker, :priority).
          order("#{Issue.table_name}.project_id ASC, #{IssuePriority.table_name}.position DESC, #{Issue.table_name}.updated_on DESC").
          to_a
      end
      def running_issue
        Worktimelog.where({:user_id => User.current.id, :flag => 0}).limit(1).to_a
      end
      def _widget(context)
        context[:iss] = issues_list
        context[:running] = running_issue
        context[:me] = User.current.id
        context[:controller].send(:render_to_string, {
          :partial =>'stopwatch/widget_timer',
          :locals => context 
        }) 
      end

      # Rendering widget to specified areas

      def view_welcome_index_left(context)
        #view_issues_sidebar_planning_bottom
        #  def self.contacts_show_in_top_menu?
        if !!Setting.plugin_redmine_worktime_log[:show_in_welcome]
          _widget(context)
        end
      end

      def view_issues_sidebar_planning_bottom(context)
        if !!Setting.plugin_redmine_worktime_log[:show_in_issues]
          _widget(context)
        end
      end

      def view_projects_show_sidebar_bottom(context)
        if !!Setting.plugin_redmine_worktime_log[:show_in_projects]
          _widget(context)
        end
      end

    end
  end
end
