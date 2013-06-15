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
class DocumentationEvent
  include Mongoid::Document
  
  field :timestamp, type: Time, default: ->{ Time.now.utc }
  field :ip, type: String, default: ->{ request.remote_ip }

  attr_readonly :timestamp, :ip
  
  embedded_in :adventure
end

class EventCheckIn < DocumentationEvent
  field :radius, type: Float
end

class EventCreate < DocumentationEvent
  field :width, type: Float
  field :height, type: Float
end