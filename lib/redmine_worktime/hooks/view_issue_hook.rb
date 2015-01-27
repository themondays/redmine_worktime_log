module RedmineWorktime
  module Hooks
    class ViewIssueHook < Redmine::Hook::ViewListener
      def get_user_total(id)
        Worktimelog.where("user_id = #{User.current.id} AND issue_id = #{id} AND flag = 1").select("COUNT(id), SUM(total) as user_time").to_a
      end
      def get_issue_total(id)
        Worktimelog.where({:issue_id => id, :flag => 1}).select("COUNT(id), SUM(total) as issue_time").to_a
      end
      def running_issue
        Worktimelog.where({:user_id => User.current.id, :flag => 0}).limit(1).to_a
      end
      def running_array
        Worktimelog.where({:user_id => User.current.id, :flag => 0}).limit(1).pluck(:issue_id)
      end
      def view_issues_show_details_bottom(context)
        context[:user_total] = get_user_total(context[:issue].id)
        context[:issue_total] = get_issue_total(context[:issue].id)
        context[:running] = running_issue
        context[:running_array] = running_array
        context[:controller].send(:render_to_string, {
          :partial => "worktimelog/widget_issue_toolbar",
          :locals => context
        })
      end
    end
  end
end
