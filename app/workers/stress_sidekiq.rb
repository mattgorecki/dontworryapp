# For load testing Sidekiq/Redis.
# Run from rails console and watch for things like WARN: ERR max number of clients reached
# 50000.times { StressSidekiq.perform_async([rand(123098)]*20)}

class StressSidekiq
  include Sidekiq::Worker
  def perform(arr)
    ## This code is just busy work to see how this handless.
    arr.each do |a|
      Digest::SHA2.new << a.to_s
    end
  end
end

