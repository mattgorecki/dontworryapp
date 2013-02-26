class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    sleep count
    puts name
    name
  end
end