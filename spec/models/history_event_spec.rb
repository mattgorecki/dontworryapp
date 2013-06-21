require 'spec_helper'

describe HistoryEvent do

  let(:adventure) { FactoryGirl.create(:adventure) }
  let(:event_properties) { {
    action: 'new_event_created'
  } }
  let(:event) { adventure.events.create(event_properties) }

  subject { event }

  it { should_not allow_mass_assignment_of(:ip) }
  it { should_not allow_mass_assignment_of(:time) }

  it { should respond_to(:action) }
  it { should_not respond_to(:time) }
  it { should_not respond_to(:details) }

  describe "#new" do
    it "should create a new one" do
      expect(event).to be_valid
    end
  end

  it "should not allow updates" do
    event.action = 'changing_event'
    expect(event.save).to eq false
  end
  
end


describe ScheduleEvent do

  let(:adventure) { FactoryGirl.create(:adventure) }
  let(:event_properties) { {
    action: 'new_event_created',
    time: 1.minute.from_now
  } }
  let(:event) { adventure.events.create(event_properties, ScheduleEvent) }

  subject { event }

  it { should_not allow_mass_assignment_of(:ip) }
  it { should allow_mass_assignment_of(:time) }

  it { should respond_to(:action) }
  it { should respond_to(:time) }
  it { should_not respond_to(:details) }

  describe "#new" do
    it { should be_instance_of(ScheduleEvent) }
  end

  describe "attributes" do
    it "should hold a time" do
      expect(event.time).to eq(event_properties[:time])
    end
  end
end


describe DetailEvent do
  let(:adventure) { FactoryGirl.create(:adventure) }
  let(:event_properties) { {
        action: 'new_event_created',
        details: 'This is a detail'
      } }
  let(:event) { adventure.events.create(event_properties, DetailEvent) }

  subject { event }

  it { should_not allow_mass_assignment_of(:ip) }
  it { should allow_mass_assignment_of(:details) }

  it { should respond_to(:action) }
  it { should_not respond_to(:time) }
  it { should respond_to(:details) }

  describe "#new" do
    it { should be_instance_of(DetailEvent) }
  end
end
