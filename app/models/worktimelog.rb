class Worktimelog < ActiveRecord::Base
  unloadable
  has_one :issue
  belongs_to :issue
  belongs_to :project
  belongs_to :user
end
class Issue < ActiveRecord::Base
  has_one :project
  belongs_to :project
end

class Project < ActiveRecord::Base
  belongs_to :issue
end

class ContactsIssue < ActiveRecord::Base
  self.primary_key = "issue_id"
  self.inheritance_column = "issue_id"
  has_one :issue
  belongs_to :contact
end

class Contacts < ActiveRecord::Base
  belongs_to :contacts_issue
end
