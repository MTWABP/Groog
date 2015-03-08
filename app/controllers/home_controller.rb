class HomeController < ApplicationController
  protect_from_forgery except: [:ghpull]
  skip_before_action :verify_authenticity_token, only: [:ghpull]
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
end
