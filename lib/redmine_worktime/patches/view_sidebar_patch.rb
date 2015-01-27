module RedmineWorktime
  module Patches
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
        context[:controller].send(:render_to_string, {
          :partial =>'stopwatch/widget_timer',
          :locals => context 
        })
        return context
      end
      def view_issues_sidebar_planning_bottom(context)
        #view_issues_sidebar_planning_bottom
        _widget(context)
      end
      def view_project_sidebar_planning_bottom(context)
        #view_issues_sidebar_planning_bottom
        _widget(context)
      end
      # def view_layouts_base_sidebar(context)
      #   #view_issues_sidebar_planning_bottom
      #   _widget(context)
      # end
    end
  end
end
