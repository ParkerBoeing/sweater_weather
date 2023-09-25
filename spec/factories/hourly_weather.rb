FactoryBot.define do
  factory :hourly_weather do
    initialize_with { new(attributes) }
    time { Faker::Time.forward(days: 2, period: :all).strftime("%I:%M %p") }
    temperature { Faker::Number.between(from: 20.0, to: 100.0).round(1) }
    conditions { Faker::Weather.condition }
    icon { Faker::LoremPixel.image(category: 'nature') }
  end
end
