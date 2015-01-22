class ChatController < ApplicationController
  def box
	@str = "<b>Hello World!</b>".html_safe
  end
end
