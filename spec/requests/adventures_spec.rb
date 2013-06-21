require 'spec_helper'
require 'requests_helper'

describe "Adventures" do

  describe "GET /adventures" do
    it "works!" do
      login(FactoryGirl.create(:user))
      get adventures_path
      response.status.should be(200)
    end

    it "redirects if not logged in)" do
      get adventures_path
      response.status.should be(302)
    end
  end
end
