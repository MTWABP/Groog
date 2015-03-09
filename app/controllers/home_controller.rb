class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:pusher_auth]
  protect_from_forgery except: [:ghpull]
  skip_before_action :verify_authenticity_token, only: [:ghpull, :pusher_auth]
  def index
  end

  def ghpull
    # TODO: make tests and run them...lets be real, I'll never do this.
    # email me so I can make sure it works manually
    who = `whoami`.strip
    if who == 'root' || who == 'groog'
      `cd /home/groog/domains/groog.me/Groog`
      `git stash`
      `git pull`
      `bundle`
      `touch tmp/restart.txt`
      logger.info "Server updated and restarted"
    end
    render status: 200, json: {success: true}
  end

  def profile
    redirect_to :back
  end
  
  def pusher_auth
    channel = params[:channel_name].sub('private-', '')
    if channel.start_with?("User")
      id = channel.sub('User-', '')
      if (current_user.id.to_s == id)
        response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
        render json: response
        return
      end
    elsif channel.start_with?("Group")
      slug = channel.sub('Group-', '')
      if (current_user.groups.active.find_by(slug: slug))
        response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
        render json: response
        return
      end
    end
    render text: 'Forbidden', status: 403
  end
end
