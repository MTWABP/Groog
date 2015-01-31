class HomeController < ApplicationController
  protect_from_forgery except: [:ghpull]
  skip_before_action :verify_authenticity_token, only: [:ghpull]
  def index
  end
  
  def ghpull
    # TODO: make tests and run them...lets be real, I'll never do this.
    # email me so I can make sure it works manually
    if `whoami` == "root\n"
      `cd /home/groog/domains/groog.me/Groog`
      `git stash`
      `git pull`
      `bundle`
      `touch tmp/restart.txt`
    end
    render status: 200, json: {success: true}
  end
end
