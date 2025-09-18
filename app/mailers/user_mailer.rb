class UserMailer < ApplicationMailer
    default from: 'noreply@demoapp.com'
  
    def verification_email(user)
      @user = user
      @verification_url = verify_user_url(token: @user.verification_token)
      
      mail(to: @user.email, subject: 'Verify Your Email Address')
    end
end