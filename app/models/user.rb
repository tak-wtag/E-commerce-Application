class User < ApplicationRecord
    has_secure_password
    
    before_create :generate_verification_token
    after_create :send_verification_email
    
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
    
    def generate_verification_token
      self.verification_token = SecureRandom.urlsafe_base64
      self.verified = false
    end
    
    def send_verification_email
      UserMailer.verification_email(self).deliver_later
    end
    
    def verify
      update(verified: true, verification_token: nil)
    end
    
    def verified?
      verified
    end
end