class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action, type: String
  field :ip, type: String, type: String, default: ->{ defined?(request) ? request.remote_ip : 'localhost' }

  embedded_in :adventure
end

class ScheduleEvent < Event
  field :time, type: Time

  def past?
    time < Time.now
  end
end

class DetailEvent < Event
  field :details, type: String
end