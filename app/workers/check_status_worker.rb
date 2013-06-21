# run manually: load "#{Rails.root}/app/workers/check_status_worker.rb"
# CheckStatusWorker.perform_async(adventure_id)

class CheckStatusWorker
  include Sidekiq::Worker
  sidekiq_options queue: :status_worker, retry: false, backtrace: true

  # core method called by Sidekiq
  def perform(adventure_id)

    @current_worker_timestamp = Time.now.utc.to_i
    @locking_key = "adventure_modify_#{adventure_id}"

    if unlocked?
      
      @adventure = Adventure.where(id: adventure_id).first

      mark_worker_was_here
      determine_adventure_state
      take_action_based_on_state
      record_actions

      remove_lock

    else

      puts "adventure #{adventure_id} was locked"
      # something is stuck
      if (@current_worker_timestamp.to_i - @active_worker_timestamp.to_i) > 120
        # TODO: Log that bad is happening.
        # TODO: Clear stuck worker?
        # TODO: Restart this stuff.
      end

    end
  end


  

  # Check to see if any other worker is working on this document.
  # unlocked => true/false if we are first to set @locking_key
  # @active_worker_timestamp => active worker's timestamp / same as current if unlocked
  def unlocked?
    unlocked, _, @active_worker_timestamp = Sidekiq.redis do |redis| 
      redis.multi do
        redis.setnx(@locking_key, @current_worker_timestamp)
        redis.expire(@locking_key, 600)
        redis.get(@locking_key)
      end
    end
    unlocked
  end

  # Remove the redis key associated with this worker working.
  def remove_lock
    Sidekiq.redis { |redis| redis.del(@locking_key) }
  end

  # Mark evidence that this worker ran.
  def mark_worker_was_here
    @adventure.events.create(action: 'worker_ran')
  end

  def determine_adventure_state
    @adventure.events.each do |event|
      # puts event.inspect
    end
    @adventure_state = 'not implented'
  end

  def take_action_based_on_state
    if @adventure_state == 'not implented'
      # puts 'nothing to see here'
    end
  end

  def reschedule_worker_at(time)
    CheckStatusWorker.perform_at(time, @adventure.id)
  end

  def reschedule_worker_in(duration)
    CheckStatusWorker.perform_in(duration, @adventure.id)
  end

  def record_actions

  end

end