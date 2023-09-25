FactoryBot.define do
  factory :daily_weather do
    initialize_with { new(attributes) }
    date { Faker::Date.backward(days: 30).strftime("%Y-%m-%d") }
    sunrise { Faker::Time.backward(days: 30, period: :morning).strftime("%I:%M %p") }
    sunset { Faker::Time.backward(days: 30, period: :evening).strftime("%I:%M %p") }
    icon { Faker::LoremPixel.image(category: 'nature') }
    max_temp { Faker::Number.between(from: 20.0, to: 100.0).round(1) }
    min_temp { Faker::Number.between(from: 0.0, to: 20.0).round(1) }
    condition { Faker::Weather.condition }
  end
end
