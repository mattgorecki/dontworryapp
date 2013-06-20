require 'spec_helper'

describe Adventure do
  user = {}
  user[:id] = 1

  it { should_not allow_mass_assignment_of(:user_id) }

  describe "#new" do
    it "should create a new one" do
      FactoryGirl.create(:adventure).should be_valid

    end
  end
end
