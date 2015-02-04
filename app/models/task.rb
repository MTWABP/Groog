class Task < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :assignee, class_name: "User"
  belongs_to :group
end
