FactoryGirl.define do
  factory :comment do
    name    { Faker::Name.name }
    email   { Faker::Internet.email }

    factory :invalid_comment do
    end
  end
end
