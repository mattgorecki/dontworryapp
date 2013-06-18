class CheckStatusWorker
  include Sidekiq::Worker
  def perform(adventure_id)
    # Fetch evidence

    # Check state

    # Take action
  end
end