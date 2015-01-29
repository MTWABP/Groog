## Setting up the environment on a MAC:
I am assuming you're running a fresh install of OSX Yosemite. If there are any problems, the errors are usually detailed enough to figure out what to do next or what to Google.

1. Install Xcode CLI tools: `xcode-select --install`
1. Install Homebrew: `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  1. Run `brew doctor` and make sure your system is ready to brew!
1. Install RVM: `\curl -sSL https://get.rvm.io | bash -s stable`
  1. You might need to restart Terminal or manually reload sources after
1. Install Ruby using RVM: `rvm install ruby`
  1. Optional: Turn off document installation with gem. `echo "gem: --no-document" >> ~/.gemrc`
1. Install Rails: `gem install rails`
1. Install Git (might not be needed if you already have git): `brew install git`
  1. `git config --global user.name "Your Full Name"`
  1. `git config --global user.email "YourEmail@Address"`
1. Install PostgreSQL (only needed for the libraries): `brew install postgresql`
1. From your fork (make one if you haven't), clone the repository to your desired work directory.
1. Install Rails project dependencies: `cd ivote/rails` and `bundle install`
1. Finally we get to run something, run ivote server: `rails s`
1. Visit `http://localhost:3000`, the api server is now running.
