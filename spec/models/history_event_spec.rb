require 'spec_helper'

describe HistoryEvent do
  it { should_not allow_mass_assignment_of(:ip) }

  describe "#new" do
    it "should create a new one" do
      adventure = FactoryGirl.create(:adventure)
      event = adventure.events.create(action: 'new_event_created')
      event.should be_valid
    end
  end
end
