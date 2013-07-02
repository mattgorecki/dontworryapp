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
  attr_accessible :time

  validates_presence_of :time
  before_save :validate_future_start_time
  validate :validate_presence_of_finish_time

  def past?
    time < Time.now
  end

  def validate_future_start_time
    if action == 'time_start_set' && time < Time.now - 1.minute
      self.time = Time.now
      if self._parent.class == Adventure
        self._parent.errors[:base] << "Start time cannot be set to past."
      end
    end
  end

  def validate_presence_of_finish_time
    if action == 'time_finish_set' && time == nil
      if self._parent.class == Adventure 
        self._parent.errors[:finish_time] << "cannot be blank."
        # errors[:finish_time] << "cannot be blank."
      end
    end
  end
end

class DetailEvent < HistoryEvent
  field :details, type: String
  attr_accessible :details

  validates_presence_of :details
end