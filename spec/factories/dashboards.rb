FactoryGirl.define do
  factory :dashboard do
    name    { Faker::Name.title }
    options { {opt: true} }

    factory :invalid_dashboard do
      name nil
    end
  end
end
