class HistoryEvent
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :action, type: String
  field :ip, type: String, type: String, default: ->{ defined?(request) ? request.remote_ip : 'localhost' }

  attr_accessible :action

  embedded_in :adventure

  before_update  :forbid_modification
  # before_destroy :forbid_modification

  protected
  def forbid_modification
    false
  end

end

class ScheduleEvent < HistoryEvent
  field :time, type: Time

  def past?
    time < Time.now
  end
end

class DetailEvent < HistoryEvent
  field :details, type: String
end