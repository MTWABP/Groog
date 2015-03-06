class ColorFactory
	def initialize
		@user_colors = {}
	end
	
	def find_usercolor(color)
		if @user_colors?(color)
			usercolor = @user_colors[color]
		else
			usercolor = UserColor.new(color)
			@user_colors[color] = usercolor
		end
		usercolor
	end
end
