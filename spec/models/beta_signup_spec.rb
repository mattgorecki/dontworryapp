require 'spec_helper'

describe BetaSignup do
  it { should respond_to(:email) }
  it { should respond_to(:invited) }
  it { should_not respond_to(:fake_attrib) }

  it { should allow_mass_assignment_of(:email) }
  it { should_not allow_mass_assignment_of(:invited) }
  
  it "should accept a valid email" do
    signup = BetaSignup.create(email: 'example1@example.com')
    signup.should be_valid
  end

  it "should not accept a invalid email" do
    signup = BetaSignup.create(email: 'This is not an email address.')
    signup.should_not be_valid
  end

  it "should not allow two of the same email" do
    signup1 = BetaSignup.create(email: 'example1@example.com')
    signup2 = BetaSignup.new(email: 'example1@example.com')
    signup2.should_not be_valid
  end
end
