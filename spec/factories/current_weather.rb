FactoryBot.define do
  factory :current_weather do
    initialize_with { new(attributes) }
    last_updated { Faker::Time.backward(days: 30, period: :evening).strftime("%Y-%m-%d %H:%M") }
    temperature { Faker::Number.between(from: 20.0, to: 100.0).round(1) }
    feels_like { Faker::Number.between(from: 20.0, to: 100.0).round(1) }
    icon { Faker::LoremPixel.image(category: 'nature') } 
    humidity { Faker::Number.between(from: 0, to: 100) }
    uvi { Faker::Number.decimal(l_digits: 1).to_f }
    visibility { Faker::Number.between(from: 0, to: 10) }
    condition { Faker::Weather.condition }
  end
end
