require 'sidekiq'

## Our production Redis has limitations. Don't go over the # of connections allowed.
## Consider the # of web workers
## Consider the # of web worker thread threads (currently in config/unicorn.rb)
## Consider the # of worker dynos connection to redis.
##
## max connections = (Heroku worker count * (concurrency + 2 reserved connections)) + (web dyno count * (client connection size * unicorn worker_process size))
##
## AWESOME TOOL: http://manuel.manuelles.nl/sidekiq-heroku-redis-calc/
## also http://manuel.manuelles.nl/blog/2012/11/13/sidekiq-on-heroku-with-redistogo-nano/
##
## Also change config/sidekiq.yml

Sidekiq.configure_client do |config|
  config.redis = { :size => 1, :url => ENV["REDISCLOUD_URL"], :namespace => 'dontworry' }
  # if Rails.env.production?
  #   config.redis[:url] = ENV["REDISCLOUD_URL"]
  #   config.redis[:namespace] = 'dontworry'
  # end
end

Sidekiq.configure_server do |config|
  # The config.redis is calculated by the 
  # concurrency value so you do not need to 
  # specify this. For this demo I do 
  # show it to understand the numbers
  config.redis = { :size => 7, :url => ENV["REDISCLOUD_URL"], :namespace => 'dontworry' }
  # if Rails.env.production?
  #   config.redis[:url] = ENV["REDISCLOUD_URL"]
  #   config.redis[:namespace] = 'dontworry'
  # end
end