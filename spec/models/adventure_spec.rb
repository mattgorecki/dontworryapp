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
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climbing Kickass Mountain')
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(true)
      end

      it "should return false if time_start_set is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climbing Kickass Mountain')
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return false if time_finish_set is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climbing Kickass Mountain')
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return false if time_alert_set is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climbing Kickass Mountain')
        expect(adventure.validate_base_events_exist).to eq(false)
      end

      it "should return false if worker_scheduled is missing" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climbing Kickass Mountain')
        expect(adventure.validate_base_events_exist).to eq(false)
      end
    end

    describe "#missing_base_events" do
      it "should return an array with missing base_events" do
        expect(adventure.missing_base_events.count).to eq(3)
      end

      it "should return an empty array if all base_events are present" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now + 1.minute)
        adventure.events << ScheduleEvent.new(action: 'time_alert_set', time: Time.now + 2.minutes)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climbing Kickass Mountain')
        adventure.events << ScheduleEvent.new(action: 'worker_scheduled', time: Time.now + 1.minute)
        expect(adventure.missing_base_events).to eq([])
      end
    end

    describe "#description" do
      it "should find the last saved description" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Walk Happy Trails')
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now + 1.minute)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climb KickAss Mountain')
        expect(adventure.description).to eq('Climb KickAss Mountain')
      end
    end

    describe "#description=" do
      it "should create a new description event" do
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Walk Happy Trails')
        adventure.description = 'Climb KickAss Mountain'
        expect(adventure.description).to eq('Climb KickAss Mountain')
      end

      it "should not create a new description event if unchanged" do
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Walk Happy Trails')
        count = adventure.events.count
        adventure.description = 'Walk Happy Trails'
        expect(adventure.events.count).to eq(count)
      end
    end


    describe "#start_time" do
      it "should find the last saved time event" do
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Walk Happy Trails')
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now + 1.minute)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climb KickAss Mountain')
        expect(adventure.start_time.to_i).to eq((Time.now.utc + 1.minute).to_i)
      end
    end

    describe "#start_time=" do
      it "should create a new time event" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        adventure.start_time = Time.now + 1.minute
        expect(adventure.start_time.utc).to eq((Time.now.utc + 1.minute))
      end

      it "should not create a new time event if time unchanged" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        count = adventure.events.count
        adventure.start_time = Time.now
        expect(adventure.events.count).to eq(count)
      end

      it "should not create a new time event if time unchanged STRING" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_start_set', time: Time.now)
        count = adventure.events.count
        adventure.start_time = Time.now.utc.to_s
        expect(adventure.events.count).to eq(count)
      end

      it "should not accept times in the past" do
        Timecop.freeze
        count = adventure.events.count        
        adventure.start_time = Time.now - 2.minutes
        expect(adventure.start_time.to_i).to eq(Time.now.utc.to_i)
      end
    end

    describe "#finish_time" do
      it "should find the last saved time event" do
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Walk Happy Trails')
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now + 1.minute)
        adventure.events << DetailEvent.new(action: 'details_description_set', details: 'Climb KickAss Mountain')
        expect(adventure.finish_time.to_i).to eq((Time.now.utc + 1.minute).to_i)
      end
    end

    describe "#finish_time=" do
      it "should create a new time event" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now)
        adventure.finish_time = Time.now + 1.minute
        expect(adventure.finish_time.to_i).to eq((Time.now.utc + 1.minute).to_i)
      end

      it "should not create a new time event if time unchanged" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now)
        count = adventure.events.count
        adventure.finish_time = Time.now
        expect(adventure.events.count).to eq(count)
      end

      it "should not create a new time event if time unchanged STRING" do
        Timecop.freeze
        adventure.events << ScheduleEvent.new(action: 'time_finish_set', time: Time.now)
        count = adventure.events.count
        adventure.finish_time = Time.now.utc.to_s
        expect(adventure.events.count).to eq(count)
      end
    end
  end
end