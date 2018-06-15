class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  
  after_initialize :ensure_session_token
  attr_reader :password
  
  # has_many :goals,
  #   foreign_key: :user_id,
  #   class_name: :Goal
  
  def self.find_by_credentials(email, password)
    
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end