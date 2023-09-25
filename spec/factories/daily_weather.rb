FactoryBot.define do
  factory :daily_weather do
    initialize_with { new(attributes) }
    
    date { Faker::Date.backward(days: 5).to_s }
    astro do 
      {
        sunrise: Faker::Time.backward(days: 1, period: :morning).strftime("%I:%M %p"),
        sunset: Faker::Time.backward(days: 1, period: :evening).strftime("%I:%M %p")
      }
    end
    day do 
      {
        maxtemp_f: Faker::Number.between(from: 20.0, to: 100.0).round(1),
        mintemp_f: Faker::Number.between(from: 0.0, to: 20.0).round(1),
        condition: {
          icon: "image_url_here",
          text: Faker::Lorem.word
        }
      }
    end
  end
end
