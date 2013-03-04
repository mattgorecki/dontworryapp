Don't Worry App
-----------------

This is where the repo description will go.

## Starting Development Server

Foreman gem handles starting mongo, rails server, and worker process. 
Run the following command to start the development server:

    bundle exec foreman start -f ProcfileDevelopment

Visit [http://localhost:3000](http://localhost:3000)

ctrl - c to quit

## Database and Job Queue Tools

### Mongo
Local: [http://localhost:28017/](http://localhost:28017/)

Genghis app: [http://localhost:5678/](http://localhost:5678/) - local only

    # start
    genghisapp
    # stop
    genghisapp --kill

### Sidekiq & Redis
Local:
[http://localhost:3000/sidekiq](http://localhost:3000/sidekiq) - admin required

Heroku:
[http://dontworry.herokuapp.com/sidekiq/](http://dontworry.herokuapp.com/sidekiq/)- admin required

## Development Environment Setup

### Install Homebrew (Mac)
[http://mxcl.github.com/homebrew/](http://mxcl.github.com/homebrew/)

### Install Mongodb (Mac w/ homebrew)
    brew install mongodb
    mongod   ## Starts Mongo. Command only needed to start Mongodb manually.

### Ruby Basics
First install compiler and RVM

Mac: Download Xcode from app store.
Open Xcode >> Preferences >> Downloads >>
Install `Command Line Tools`

Note: Ben has had bad luck with RailsInstaller for OS X. It does wierd things.

Linux: You probably have a compiler installed. :)

Visit [RVM website - https://rvm.io/](https://rvm.io/), and follow installation instructions.


### Project Specific Ruby version and Gems
    rvm install 1.9.3-p392

cd out and back into dontworry rails folder &
answer yes to .rvmrc question if asked

    bundle install

### Genghis (optional...for Mongo debugging)
[https://github.com/bobthecow/genghis](https://github.com/bobthecow/genghis)

    gem install genghis    
    genghisapp
    genghisapp --kill

### Lost?
Solid tutorial is available at [http://railsapps.github.com/installing-rails.html](http://railsapps.github.com/installing-rails.html)

Other
-----

### Check for Common Security vulnerabilities
    brakeman -o ./tmp/brakeman.html; launchy ./tmp/brakeman.html 

### Temp reference
    rails new dontworry --skip-active-record --skip-test-unit
    gem install foreman
    echo "RACK_ENV=development" >>.env

