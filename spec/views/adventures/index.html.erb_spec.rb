require 'spec_helper'

describe "adventures/index" do
  before(:each) do
    assign(:adventures, [
      stub_model(Adventure),
      stub_model(Adventure)
    ])
  end

  # it "renders a list of adventures" do
    # render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  # end
end
