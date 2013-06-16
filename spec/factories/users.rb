FactoryGirl.define do
  factory :user do
    name    { Faker::Name.name }
    email   { Faker::Internet.email }
    password 'qwertyui'
    password_confirmation 'qwertyui'
    confirmed_at Time.now

    factory :invalid_user do
      email nil
    end

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end
    factory :restaurant do
      after(:create) { |user| user.add_role(:restaurant) }
    end
    factory :basic_user do
      after(:create) { |user| user.add_role(:basic_user) }
    end
  end
end
