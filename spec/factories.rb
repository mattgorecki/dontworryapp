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

  factory :history_event do
    user
    adventure
    description "Lorem ipsum"
  end
end