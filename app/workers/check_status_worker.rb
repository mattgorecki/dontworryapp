class CheckStatusWorker
  include Sidekiq::Worker
  def perform(arr)
    ## This code is just busy work to see how this handless.
    arr.each do |a|
      Digest::SHA2.new << a.to_s
    end
  end
end