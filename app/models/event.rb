class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip, type: String, type: String, default: ->{ defined?(request) ? request.remote_ip : 'localhost' }

  embedded_in :adventure
end
