class Adventure
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String

  attr_accessible :events, :start_time, :finish_time, :description

  embeds_many :events, class_name: "HistoryEvent", cascade_callbacks: true
  belongs_to :user

  after_create :add_event_adventure_created

  def add_event_adventure_created
    events.create(action: 'adventure_created')
  end

  def base_events
    # NEED TO ENABLE
    #   time_alert_set
    #   worker_scheduled
    %w{
      adventure_created
      details_description_set
      time_start_set
      time_finish_set
    }
  end

  def validate_base_events_exist
    base_events_clone = base_events.map(&:dup)
    events.each do |event|
      return false unless event.valid?
      base_events_clone.delete(event.action)
    end
    base_events_clone.count == 0
  end

  def missing_base_events
    base_events_clone = base_events.map(&:dup)
    events.each do |event|
      return false unless event.valid?
      base_events_clone.delete(event.action)
    end
    base_events_clone.each do |event|
      errors[event] << "cannot be blank."
    end
    base_events_clone
  end

  def description
    description_event = events.where(action: 'details_description_set').last
    description_event ? description_event.details : ''
  end

  def description=(description)
    unless self.description == description
      events.create({action: 'details_description_set', details: description}, DetailEvent)
    end
  end

  def start_time
    start = events.where(action: 'time_start_set').last
    start ? start.time : nil
  end

  def start_time=(time)
    time = Chronic.parse(time) if time.is_a? String
    unless start_time.to_i == time.to_i
      events.create({action: 'time_start_set', time: time}, ScheduleEvent)
    end
  end

  def finish_time
    finish = events.where(action: 'time_finish_set').last
    finish ? finish.time : nil
  end

  def finish_time=(time)
    time = Chronic.parse(time) if time.is_a? String
    unless finish_time.to_i == time.to_i
      events.create({action: 'time_finish_set', time: time}, ScheduleEvent)
    end
  end

end
