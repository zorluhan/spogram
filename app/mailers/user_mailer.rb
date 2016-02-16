class UserMailer < ActionMailer::Base
  default from: "Capish <mail@capish.co>"

  # welcome email to instauser after signup
  def instauser_welcome_email(user_id)
    @user = Instauser.find_by(id: user_id)
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  # reject email to instauser after signup
  def instauser_reject_email(user_id)
    @user = Instauser.find_by(id: user_id)
    mail(to: @user.email, subject: 'Application Rejected')
  end

  # proposal email by branuser to instauser
  def send_new_proposal_email(instauser_id, branduser_id, charge_id)
    @insta_user = Instauser.find_by(id: instauser_id)
    @brand_user = Branduser.find_by(id: branduser_id)
    @charge     = Charge.find_by(id: charge_id)

    mail(to: @insta_user.email, subject: 'New Propsal')
  end

  # new message by branuser to instauser
  def new_message_from_branduser_email(instauser_id, branduser_id, message_id)
    @insta_user = Instauser.find_by(id: instauser_id)
    @brand_user = Branduser.find_by(id: branduser_id)
    @message    = Message.find_by(id: message_id)

    mail(to: @insta_user.email, subject: 'New Message')
  end
end
