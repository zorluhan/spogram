class UserMailer < ActionMailer::Base
  default from: "Capish <mail@capish.co>"

  # welcome email to instauser after signup
  def instauser_welcome_email(user_id)
    @user = Instauser.find_by(id: user_id)
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Capish!')
  end

  # welcome email to branduser after signup
  def branduser_welcome_email(user_id)
    @user = Branduser.find_by(id: user_id)
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Capish!')
  end

  # reject email to instauser after signup
  def instauser_reject_email(user_id)
    @user = Instauser.find_by(id: user_id)
    mail(to: @user.email, subject: 'Your Capish application rejected, it is not the end of the world!')
  end

  # new message by branuser to instauser
  def new_message_from_branduser_email(instauser_id, branduser_id, message_id)
    @insta_user = Instauser.find_by(id: instauser_id)
    @brand_user = Branduser.find_by(id: branduser_id)
    @message    = Message.find_by(id: message_id)

    mail(to: @insta_user.email, subject: "New Message from #{@brand_user.coname}" )
  end

  # new message by instauser to branuser
  def new_message_from_instauser_email(branduser_id, instauser_id, message_id)
    @brand_user = Branduser.find_by(id: branduser_id)
    @insta_user = Instauser.find_by(id: instauser_id)
    @message    = Message.find_by(id: message_id)

    mail(to: @brand_user.email, subject: "New Message from #{@insta_user.fullname}" )
  end

end


