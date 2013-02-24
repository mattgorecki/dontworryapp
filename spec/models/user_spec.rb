require 'spec_helper'

describe User do
  
  describe "validations" do
    it "should fail registration if in production mode" do
      if Rails.env.production?
        @user = Factory(:user).should_not be_valid
      end
    end
  end
end
