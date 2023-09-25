FactoryBot.define do
  factory :hourly_weather do
    initialize_with { new(attributes) }
    time { Faker::Time.forward(days: 2, period: :all).strftime("%I:%M %p") }
    temperature { Faker::Number.between(from: 20.0, to: 100.0).round(1) }
    condition do
      {
        icon: "//cdn.weatherapi.com/weather/64x64/night/116.png",
        text: Faker::Lorem.word
      }
    end
  end
end
