FactoryGirl.define do
  factory :user do
    # sequence(:name)   { |n| "Person #{n}" }
    sequence(:email)  { |n| "person-#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :adventure do
    description "Lorem ipsum"
    user
  end
end