require "rails_helper"

RSpec.describe User, type: :model do

  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it { should validate_confirmation_of(:password) }

    it "properly stores passwords" do
      user = User.create!(email: 'test@test.com', password: 'password123', password_confirmation: 'password123')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end

    it "generates an API key upon creation" do
      user = User.create!(email: 'test@test.com', password: 'password123', password_confirmation: 'password123')
      expect(user.api_key.length).to eq(40)
    end
  end
end