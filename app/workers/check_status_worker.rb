class CheckStatusWorker
  include Sidekiq::Worker
  def perform(evidence_id)
    # Fetch evidence

    # Check state

    # Take action
  end
end