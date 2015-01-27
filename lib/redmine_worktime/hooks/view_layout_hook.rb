module RedmineWorktime
  module Hooks
    class ViewLayoutHook < Redmine::Hook::ViewListener
      render_on :view_layouts_base_html_head, :partial => "worktimelog/sentinel"
    end
  end
end
