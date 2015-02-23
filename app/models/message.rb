class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :channel, polymorphic: true

  validates :body, presence: true
end
