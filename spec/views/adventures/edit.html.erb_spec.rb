require 'spec_helper'

describe "adventures/edit" do
  before(:each) do
    @adventure = assign(:adventure, stub_model(Adventure))
  end

  it "renders the edit adventure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adventures_path(@adventure), :method => "post" do
    end
  end
end
