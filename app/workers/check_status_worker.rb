# run manually: load "#{Rails.root}/app/workers/check_status_worker.rb"
# CheckStatusWorker.perform_async(adventure_id)

class CheckStatusWorker
  include Sidekiq::Worker
  
  def perform(adventure_id)
    # Let the other workers know we are working on this.
    @locking_key = "adventure_wip_#{adventure_id}"

    if unlocked?
      # Fetch evidence
      @adventure = Adventure.where(id: adventure_id).first

      check_adventure_state
      determine_next_action

      remove_lock
    else
      # should we go away or reschedule?
      puts "adventure #{adventure_id} was locked"
    end
  end


  def unlocked?
    unlocked, _ = Sidekiq.redis do |redis| 
      redis.multi do
        redis.setnx(@locking_key, 'wip')
        redis.expire(@locking_key, 60)
      end
    end
    unlocked
  end

  def remove_lock
    Sidekiq.redis { |redis| redis.del(@locking_key) }
  end

  def check_adventure_state
    @adventure.events.each do |event|
      puts event.inspect
    end
    @adventure_state = 'not implented'
  end

  def determine_next_action
    if @adventure_state == 'not implented'
      puts 'nothing to see here'
    end
  end

end