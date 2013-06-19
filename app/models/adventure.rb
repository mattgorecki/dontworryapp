class Adventure
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :description, type: String
  field :departure_time, type: Time
  field :expected_return_time, type: Time
  field :alert_time, type: Time

  attr_accessible :description, :departure_time, :expected_return_time, :alert_time

  embeds_many :events, class_name: "HistoryEvent"
  belongs_to :user
end
