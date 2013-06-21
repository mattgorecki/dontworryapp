class Adventure
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String

  attr_accessible :events

  embeds_many :events, class_name: "HistoryEvent"
  belongs_to :user

  after_create :add_event_adventure_created


  def add_event_adventure_created
    events.create(action: 'adventure_created')
  end

  def validate_base_events_exist
    base_events = %w{
      adventure_created
      time_start_set
      time_end_set
      time_alert_set
      worker_scheduled
    }
    events.each do |event|
      return false unless event.valid?
      base_events.delete(event.action)
    end
    base_events.count == 0
  end
end
