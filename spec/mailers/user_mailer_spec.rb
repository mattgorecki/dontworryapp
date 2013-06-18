require "spec_helper"

describe UserMailer do
  
  before do
    @user = User.new(name: "Example User", email: "user@example.org", 
                   password: "foobar", password_confirmation: "foobar")
  end

  describe "beta_signup_confirmation" do
    let(:mail) { UserMailer.beta_signup_confirmation(@user) }

    it "renders the headers" do
      mail.subject.should eq("Thanks from Don't Worry!")
      mail.to.should eq(["user@example.org"])
      mail.from.should eq(["dontworryapp@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Thank you for signing up for Don't Worry!\r\n\r\nWe are hard at work on the Don't Worry app and we will be sending you emails about our progress.\r\n\r\nYou can really help us out by sharing with your friends. http://www.dontworryapp.com\r\n\r\nThank you,\r\nThe Don't Worry Team")
    end
  end

end
