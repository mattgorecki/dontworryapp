require 'spec_helper'

describe Adventure do
  user = {}
  user[:id] = 1

  it { should_not allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:departure_time) }
  it { should allow_mass_assignment_of(:expected_return_time) }
  it { should allow_mass_assignment_of(:alert_time) }

end
