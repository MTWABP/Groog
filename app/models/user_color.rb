class UserColor < ActiveRecord::Base
	attr_reader :color
	
	def initialize(color)
		@color = color
	end
end
