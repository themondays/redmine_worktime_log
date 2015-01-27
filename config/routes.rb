# Plugin"s routes
get "worktime/stopwatch", :to => "stopwatch#timer"
get "worktime/stopwatch/:id", :to => "stopwatch#timer"
post "worktime/stopwatch/:id", :to => "stopwatch#timer"
get "worktime/stopwatch/snapup/:id", :to => "stopwatch#snapup"
get "users/:id/worktime", :to => "worktimelog#user_summary"

match "users/:id/worktime" => "worktimelog#user_summary"
match "issues/:issue_id/worktime" => "worktimelog#issue_summary"
match "projects/:project_id/worktime" => "worktimelog#project_summary"


resources :projects do
 resources :worktimelog, :only => [:project_summary]
end

resources :issues do
 resources :worktimelog, :only => [:issue_summary,:snapup]
end

resources :users do
 resources :worktimelog, :only => [:user_summary]
end

