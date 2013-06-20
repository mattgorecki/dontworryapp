FactoryGirl.define do
  factory :user do
    # User.stub!(:beta_invited?).and_return(true)
    # sequence(:name)   { |n| "Person #{n}" }
    sequence(:email)  { |n| "person-#{n}@example.com"}
    password "foobar29"
    password_confirmation "foobar29"
  end
  
  factory :adventure do
    user
  end

  factory :adventure1, :class => :adventure do
    events  {[FactoryGirl.build(:history_event),FactoryGirl.build(:schedule_event)]}
  end

  factory :history_event do
    action "history_event"
  end

  factory :adventure_created, :class => :history_event do
    action "adventure_created"
  end

  factory :schedule_event do
    action 'factory_action'
    time 1.minute.from_now
  end
end