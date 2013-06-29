require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AdventuresHelper. For example:
#
# describe AdventuresHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AdventuresHelper do
  describe "format_action" do

    let(:adventure) { FactoryGirl.create(:adventure) }
    let(:detail_event_properties) { {
          action: 'new_event_created',
          details: 'This is a detail'
        } }
    let(:detail_event) { adventure.events.create(detail_event_properties, DetailEvent) }
    let(:event) { adventure.events.create()}

    it "should convert 'adventure_created' to 'Adventure Created'" do
      event.action = 'adventure_created'
      expect(helper.format_action(event)).to eq('Adventure Created')
    end
  end
end
