FactoryBot.define do
  factory :location do
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end
