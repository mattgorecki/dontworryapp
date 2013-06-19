require 'spec_helper'

describe User do

  describe "validations" do
    it "should fail validation if not beta_invited?" do
      FactoryGirl.build(:user).should_not be_valid
    end
    it "should validate emails if beta_invited?" do
      valid_user = FactoryGirl.build(:user)
      valid_user.stub!(:beta_invited?).and_return(true)
      valid_user.should have(0).errors_on(:email)
    end
  end

  describe "#email" do
    it "should store email" do
      user = FactoryGirl.build(:user, email: 'leo@aol.com')
      user.stub!(:beta_invited?).and_return(true)
      user.save
      user.email.should eq 'leo@aol.com'
    end
  end
end
