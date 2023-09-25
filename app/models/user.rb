class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, confirmation: true
  before_create :generate_api_key
  has_secure_password

  private
  
  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(20)
      break unless User.exists?(api_key: api_key)
    end
  end
end

