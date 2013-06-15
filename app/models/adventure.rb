class Adventure
  include Mongoid::Document
  field :user_id, type: String
  field :description, type: String
  field :departure_time, type: Time
  field :expected_return_time, type: Time
  field :alert_time, type: Time

  attr_accessible :description, :departure_time, :expected_return_time, :alert_time
end
