class Adventure
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String

  attr_accessible :events

  embeds_many :events, class_name: "HistoryEvent"
  belongs_to :user
end
