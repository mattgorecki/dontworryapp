Don't Worry App
-----------------

This is where the repo description will go.

********************************************************************************

Starting Development Server
===========================

Foreman gem handles starting mongo, rails server, and worker process.

Start the development server and all dependencies. (prob Mac)

    bundle exec foreman start -f ProcfileDevelopment

Start the dev server without Redis and MongoDB because
you already have it running. (prob Linux)
    
    foreman start -f ProcfileDevelopmentNoDB

or manually if the databases are already running

    rails s
    bundle exec sidekiq -e development -C config/sidekiq.yml

Visit [http://localhost:3000](http://localhost:3000)

ctrl - c to quit

## Development Monitoring
### Sidekiq & Redis
Local:
[http://localhost:3000/sidekiq](http://localhost:3000/sidekiq) - admin required

### Mongo
Local: [http://localhost:28017/](http://localhost:28017/)

Genghis app: [http://localhost:5678/](http://localhost:5678/) - local only

    # start
    genghisapp
    # stop
    genghisapp --kill

Run tests
=========
    
    guard

********************************************************************************

Production
==========

During the development stage, sidekiq is turned off to avoid unecessary billing.
Run with:

    heroku run bin/sidekiq -e production -C config/sidekiq.yml --app dontworry

ctrl + c when you are done to kill remote worker threads and stop the $$$

Run `heroku ps` to see what processes are left running.

### Sidekiq & Redis Monitoring
Heroku:
[http://dontworry.herokuapp.com/sidekiq/](http://dontworry.herokuapp.com/sidekiq/)- admin required

********************************************************************************

Staging
=======

    heroku config:add RACK_ENV='staging' --app dw-staging
    heroku config:add RAILS_ENV='staging' --app dw-staging

During the development stage, sidekiq is turned off to avoid unecessary billing.
Run with:

    heroku run bin/sidekiq -e production -C config/sidekiq.yml --app dw-staging

ctrl + c when you are done to kill remote worker threads and stop the $$$

Run `heroku ps` to see what processes are left running.

### Sidekiq & Redis Monitoring
Heroku:
[http://dw-staging.herokuapp.com/sidekiq/](http://dw-staging.herokuapp.com/sidekiq/)- admin required

********************************************************************************

Development Environment Setup
=============================
## Mac OS X specific
Note: Ben has had bad luck with RailsInstaller for OS X. It does wierd things. We
will be doing this step by step.
### Install Xcode & compiling tools
Download Xcode from app store.

Open Xcode >> Preferences >> Downloads >>

Install `Command Line Tools`

### Install Homebrew
[http://mxcl.github.com/homebrew/](http://mxcl.github.com/homebrew/)

### Install Basic Dependencies
RVM Dependencies
    
    brew install bash curl git

Ruby Dependencies
    
    brew install autoconf automake apple-gcc42 libtool pkg-config openssl readline libyaml sqlite libxml2 libxslt libksba

### Install Project Dependencies
    brew install mongodb redis

### Install RVM & Ruby

Visit [RVM website - https://rvm.io/](https://rvm.io/), and follow installation instructions.

    \curl -L https://get.rvm.io | bash -s stable --ruby

## Ubuntu/Mint specific
### Install Dependencies
RVM Dependencies

    sudo apt-get --no-install-recommends install bash curl git patch bzip2

Ruby Dependencies - we will be compiling Ruby ourselves with RVM below

    sudo apt-get --no-install-recommends install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev

node.js

    sudo apt-get install nodejs

### Install Project Dependencies
    sudo apt-get install redis-server mongodb-server
    

### Install RVM & Ruby
RVM

    \curl -#L https://get.rvm.io | bash -s stable --ruby     ### not as sudo

    which ruby  #shows the system default ruby now
    rvm list #if it doesnt work, restart terminal session

## Both Mac & Linux
### Install project specific Ruby version
    rvm install 1.9.3-p392

### Check that project RVM settings work
cd out and back into dontworry rails folder &
answer yes to .rvmrc question if asked

If not asked, make sure your ~/.bash_profile and ~/.bashrc are being loaded. 

Not working on Unbuntu/Mint/Debian? append the following to your ~/.bashrc

    . ~/.bash_profile

Not working on Mac? maybe ?? add the following to ~/.bash_profile
    
    source ~/.bashrc 

### Install project Ruby gems

    gem install bundler
    bundle install

### Genghis (optional...for Mongo debugging)
[https://github.com/bobthecow/genghis](https://github.com/bobthecow/genghis)

    gem install genghisapp
    genghisapp
    genghisapp --kill

### Lost?
Solid tutorial is available at [http://railsapps.github.com/installing-rails.html](http://railsapps.github.com/installing-rails.html)

********************************************************************************

Other
-----

### Check for Common Security vulnerabilities
    brakeman -o ./tmp/brakeman.html; launchy ./tmp/brakeman.html 

### Temp reference
    rails new dontworry --skip-active-record --skip-test-unit
    gem install foreman
    echo "RACK_ENV=development" >>.env

Flush redis in production

    $redis.flushall


TODO
----

Figure out if kickstand is needed between sidekiq and mongoid to disconnect workers
https://github.com/mongoid/kiqstand


Create a new Heroku App from this repo
--------------------------------------
Use the JRuby buildpack commit that matches our version of jruby

    heroku create --remote [NAMETHIS]


Email config

    heroku config:add GMAIL_USERNAME='FILL THIS IN'
    heroku config:add GMAIL_PASSWORD='FILL THIS IN'

Add config for Redis and MongoDB service providers

Push code