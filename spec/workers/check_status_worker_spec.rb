require 'spec_helper'
require 'sidekiq/testing'

describe CheckStatusWorker do

  let(:status_worker) { CheckStatusWorker.new }
  let(:adventure) { FactoryGirl.create(:adventure) }

  describe "perform_async" do
    it 'should increment the sidekiq job count' do
      expect {
        CheckStatusWorker.perform_async(adventure.id)
      }.to change(CheckStatusWorker.jobs, :size).by(1)
    end
  end

  describe "perform_at" do
    it 'should schedule a job' do
      CheckStatusWorker.perform_at(Time.new(2014,1,23,14,00), adventure.id)
      expect(CheckStatusWorker).to have_queued_job_at(Time.new(2014,1,23,14,00),adventure.id)
    end
  end

  describe "#perform" do
    it 'should return successfully' do
      expect(status_worker.perform(adventure.id)).to eq 1
    end
  end

  describe "#reschedule_worker_at" do
    it "should add a new task to the queue with the correct adventure_id" do
      status_worker.instance_variable_set(:@adventure, adventure) 
      status_worker.reschedule_worker_at(Time.new(2014,2,23,14,00))
      expect(CheckStatusWorker).to have_queued_job_at(Time.new(2014,2,23,14,00),adventure.id)
    end
  end

  describe "#reschedule_worker_in" do
    it "should add a new task to the queue with the correct adventure_id" do
      status_worker.instance_variable_set(:@adventure, adventure)
      status_worker.reschedule_worker_in(1.hour)
      expect(CheckStatusWorker).to have_queued_job_at(1.hour.from_now,adventure.id)
    end
  end

  describe "#mark_worker_was_here" do
    it "should add an event to the adventure" do
      event_count = adventure.events.count
      status_worker.perform(adventure.id)
      reloaded_adventure = Adventure.where(id: adventure.id).first
      expect(reloaded_adventure.events.count).to eq(event_count + 1)
    end
  end

  # if state is 'such-n-such' then expect 'some-queue' to grow by one
  # if state is 'something' then expect 'some-method' to be called
  # etc
end