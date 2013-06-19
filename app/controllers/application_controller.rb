class ApplicationController < ActionController::Base
  protect_from_forgery

  ## Block public access to staging environment.
  if Rails.env.staging? 
    http_basic_authenticate_with :name => "dont", :password => "worryman" 
  end

end
