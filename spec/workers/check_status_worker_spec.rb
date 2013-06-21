require 'spec_helper'
require 'sidekiq/testing'

describe CheckStatusWorker do

  status_worker = CheckStatusWorker.new

  describe "perform_async" do
    it 'should increment the sidekiq job count' do
      expect {
        CheckStatusWorker.perform_async(FactoryGirl.create(:adventure))
      }.to change(CheckStatusWorker.jobs, :size).by(1)
    end
  end

  describe "perform_at" do
    it 'should schedule a job' do
      adventure = FactoryGirl.create(:adventure)
      CheckStatusWorker.perform_at(Time.new(2014,1,23,14,00), adventure.id)
      expect(CheckStatusWorker).to have_queued_job_at(Time.new(2014,1,23,14,00),adventure.id)
    end
  end

  describe "#perform" do
    it 'should return successfully' do
      adventure = FactoryGirl.create(:adventure)
      expect(status_worker.perform(adventure.id)).to eq 1
    end
  end

  # if state is 'such-n-such' then expect 'some-queue' to grow by one
  # if state is 'something' then expect 'some-method' to be called
  # etc
end