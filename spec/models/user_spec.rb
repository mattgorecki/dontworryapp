require 'spec_helper'

describe User do

  describe "validations" do
    it "should fail validation if not beta_invited?" do
      Rails.stub(env: ActiveSupport::StringInquirer.new("production"))
      FactoryGirl.build(:user).should_not be_valid
    end
    it "should validate emails if beta_invited?" do
      valid_user = FactoryGirl.build(:user)
      valid_user.stub!(:beta_invited?).and_return(true)
      expect(valid_user).to have(0).errors_on(:email)
    end
  end

  describe "#email" do
    it "should store email" do
      user = FactoryGirl.build(:user, email: 'leo@aol.com')
      user.stub!(:beta_invited?).and_return(true)
      user.save
      expect(user.email).to eq 'leo@aol.com'
    end
  end
end
