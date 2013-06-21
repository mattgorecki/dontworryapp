require 'spec_helper'

describe Adventure do

  let(:adventure) { FactoryGirl.create(:adventure) }

  it { should_not allow_mass_assignment_of(:user_id) }
  

  describe "#new" do
    it "should create a new one" do
      expect(adventure).to be_valid
    end
  end

  describe "embeded events" do
    it { should respond_to(:events) }

    it "should automatically create adventure_created event" do
      expect(adventure.events.first.action).to eq('adventure_created')
    end

    describe "#validate_base_events_exist" do
      it "should return false if all base_events are not present" do
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return true if all base_events are present" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_end_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(true)
      end

      it "should return false if time_start_set is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_end_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return false if time_end_set is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return false if time_alert_set is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_end_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return false if worker_scheduled is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_end_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        expect(adventure.validate_base_events_exist).to eq(false)
      end
    end
  end
end
