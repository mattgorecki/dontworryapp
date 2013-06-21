require 'spec_helper'

describe "adventures/new" do
  before(:each) do
    assign(:adventure, stub_model(Adventure).as_new_record)
  end

  it "renders new adventure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adventures_path, :method => "post" do
    end
  end
end
