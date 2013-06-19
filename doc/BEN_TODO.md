Check on mongo db config if you start using eager loading...aka prefetching
an associated record. May not happen much with embedded documents.
mongoid.yml
  # identity_map_enabled: false

ACTION                  TIME  DETAILS
adventure_created     | nil   details

time_start_set        | time
time_end_set          | time
time_alert_set        | time
                      |
worker_ran            | nil    nil
worker_scheduled      | time

snooze_recieved       | nil    nil
check_in_recieved     | nil    nil

adventure_archived    | nil


adventure
    embeds_many :events
    event
        embedded_in :adventure

######################################
class Adventure
  include Mongoid::Document
  
  field :description, type: String
  field :departure_time, type: Time, default: ->{ Time.now.utc }
  field :expected_return_time, type: Time
  field :alert_time, type: Time

  embeds_many :events
end

class WildernessTrip < Adventure
  field :version, type: Integer
  scope :recent, where(:version.gt => 3)
end

class NationalParkTrip < WildernessTrip
end

#####################################
class Event
  include Mongoid::Document
  
  field :timestamp, type: Time, default: ->{ Time.now.utc }
  field :ip, type: String, default: ->{ request.remote_ip }

  attr_readonly :timestamp, :ip
  
  embedded_in :adventure
end

class EventCheckIn < Event
  field :radius, type: Float
end

class EventCreate < Event
  field :width, type: Float
  field :height, type: Float
end