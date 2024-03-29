source 'https://rubygems.org'

# Heroku needs Ruby version 1.9.3 specified or uses 1.9.2
ruby '1.9.3'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production, :staging do
  # Use unicorn as the app server
  gem 'unicorn'
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem "factory_girl_rails", "~> 4.2.1"

  # guard
  gem 'rb-fsevent'
  gem 'guard-rspec'
  gem "spork-rails"
  gem 'guard-spork'
  # gem 'guard-livereload'

  gem 'database_cleaner'
end

group :development do
  # Opens sent emails in browser.
  gem "letter_opener"
  gem 'foreman', :require => false
  # gem "brakeman"
  # gem "genghisapp", :require => false
  # gem "bson_ext", :require => false
end

group :test do
  gem "timecop"
end

# All environments
gem 'jquery-rails'
gem 'mongoid'
gem 'devise'

gem 'sidekiq'
gem 'sidekiq-failures'
gem 'slim'
# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', '>= 1.3.0', :require => nil

gem 'state_machine'
gem 'bootstrap-sass'

gem 'chronic'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
