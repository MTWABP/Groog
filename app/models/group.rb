class Group < ActiveRecord::Base
  has_many :users, through: :group_memberships
end
