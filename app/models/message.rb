class Message < ActiveRecord::Base

  belongs_to :instauser
  belongs_to :branduser

  after_create :send_email

  private
    def send_email
      if sender == 0
        UserMailer.new_message_from_branduser_email(instauser_id, branduser_id, id).deliver!
      end
    end
end
