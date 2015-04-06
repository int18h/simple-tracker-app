class UserMailer < ApplicationMailer
  default from: 'notifications@simple-tracker-app.com'
 
  def forgot_password_email(user)
    @user = user
    @url  = 'http://simple-tracker-app.com/signin'
    mail(to: @user.email, subject: 'Restore your password')
  end
end
