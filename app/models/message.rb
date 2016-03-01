class Message < ActiveRecord::Base

  belongs_to :instauser, dependent: :destroy
  belongs_to :branduser, dependent: :destroy

  after_create :send_email

  private
    def send_email
      if sender == 0
        UserMailer.delay.new_message_from_branduser_email(instauser_id, branduser_id, id)
      elsif sender == 1
        UserMailer.delay.new_message_from_instauser_email(branduser_id, instauser_id, id)
      end
    end
end
