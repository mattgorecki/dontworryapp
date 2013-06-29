module AdventuresHelper

  def format_action(event)
    case event.action
    when 'adventure_created'
      'Adventure Created'
    when 'worker_ran'
      'Analyzed Adventure Status'
    when 'details_description_set'
      "Set Description to \"#{event.details}\"."
    when 'time_start_set'
      "Set Start Time to #{event.time.to_s(:long_time_12)}"
    when 'time_finish_set'
      "Set Finish Time to #{event.time.to_s(:long_time_12)}"
    else
      'got nothing'
    end
  end

end
