class Task < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :assignee, class_name: "User"
  belongs_to :group
  has_many :comments, class_name: "Message", as: "channel"

  validates :task, presence: true
  validates :description, presence: true
  validates :due_date, presence: true

end
