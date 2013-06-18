# run manually: load "#{Rails.root}/app/workers/check_status_worker.rb"

class CheckStatusWorker
  include Sidekiq::Worker
  def perform(adventure_id)
    # Fetch evidence
    adventure = Adventure.where(id: adventure_id).first

    # Check state
    adventure.events.each do |event|
      puts event.inspect
    end
    # Take action
  end
end